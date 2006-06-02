Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWFBHh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWFBHh7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWFBHh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:37:59 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:590 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751269AbWFBHh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:37:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mp3Bv1zk3pNcOhqQVjbqHWhyRrX/xnNiuUE5OXnLlA5nRZAyIlQeRlIvDrh1ewA0tbqgla3EzAHg6y5hIhEOa1GoYyhh3N1E8XIz/J2DEo86xyzIQI6CDXg7ZBB+leJieeEiBPckGBNknrpkJHOxa1YnEcKFsu6551MercWlxSU=
Message-ID: <8bf247760606020037x7eedab52qa9c736bdba740cb8@mail.gmail.com>
Date: Fri, 2 Jun 2006 00:37:58 -0700
From: Ram <vshrirama@gmail.com>
To: "Paulo Marques" <pmarques@grupopie.com>
Subject: Re: printk's - i dont want any limit howto?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <447EEDCB.1070002@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8bf247760606010025p38131240ia133cc3124f93bf7@mail.gmail.com>
	 <447EEDCB.1070002@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Actually even though the printks are getting executed.

  ONLY some appear. I have given both KERN_ERR and KERN_DEBUG


   Its not the log level problem. probably the buffer or something else.
   am not sure on that.

   i have given printk_ratelimit_burst= 1000 ; printk_ratelimit_jiffies = 0 ;


   but it does not work.


   Please Advice,


   Regards,
   sriram

On 6/1/06, Paulo Marques <pmarques@grupopie.com> wrote:
> Ram wrote:
> > Hi,
>
> Hi,
>
> >  I have a driver full of printks. i am trying to understand the way
> > the driver functions using printks
> >
> >  So, i have a situation where i want all the printk's to be printed
> > come whatever.
>
> That is the normal behavior.
>
> >   I dont want any rate limiting or anything else that prevents from
> > my printks from appearing on the screen or dmesg.
> >
> > Its really confusing when only one of your printks appear and some
> > just dont appear even though you expect them to appear.
> >
> >  Is there any way to make all the printks to appear come what may?.
> > If so, how do  i do it?.
> >
> >  Went through the printk.c am not sure setting the
> > printk_ratelimit_jiffies = 0 and printk_ratelimit_burst= 1000 will do?
> >
> >  am not sure if printk_ratelimit_jiffies = 0 is valid.
>
> These are just used by "printk_ratelimit()" in constructs such as:
>
> if (printk_ratelimit())
>          printk(KERN_INFO "some message that may appear very often");
>
> If you simply use printk, there should be no rate limiting.
>
> > please advice.
>
> I would say your printk's are not getting called at all or the log level
> of the messages is not sufficient for them to appear on the console or
> on the log. See Documentation/filesystems/proc.txt ->
> proc/sys/kernel/printk and syslog(2) for more documentation on this.
>
> I hope this helps,
>
> --
> Paulo Marques - www.grupopie.com
>
> Pointy-Haired Boss: I don't see anything that could stand in our way.
>             Dilbert: Sanity? Reality? The laws of physics?
>
