Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVGWXwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVGWXwF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 19:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVGWXwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 19:52:05 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:1562 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262093AbVGWXwD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 19:52:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tBd8k3eSxommdpAN2xk4NXM6QjOtPmDQTq2sUDW0d7i0+qYcVNmUG9YjBNOzoi+rpYU3VsK6jEDj0cJNV5nWlITeRVGD5wZpGaj4alASgUcRH4a8tgPW6rF00h/nFFsY344U5sW3L9PTsZWMj3gh46/ZcJfX7A+c3VEzM31TVaQ=
Message-ID: <9a874849050723165276f73cdf@mail.gmail.com>
Date: Sun, 24 Jul 2005 01:52:03 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: randy_dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Cc: torvalds@osdl.org, rlrevell@joe-job.com, cw@f00f.org, akpm@osdl.org,
       len.brown@intel.com, dtor_core@ameritech.net, vojtech@suse.cz,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
In-Reply-To: <20050723164802.70b51b8a.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42D3E852.5060704@mvista.com>
	 <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe>
	 <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <9a874849050714170465c979c3@mail.gmail.com>
	 <1121386505.4535.98.camel@mindpipe>
	 <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>
	 <42D731A4.40504@gmail.com>
	 <20050723164802.70b51b8a.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/05, randy_dunlap <rdunlap@xenotime.net> wrote:
> On Fri, 15 Jul 2005 05:46:44 +0200 Jesper Juhl wrote:
> 
> > +static int __init jiffies_increment_setup(char *str)
> > +{
> > +     printk(KERN_NOTICE "setting up jiffies_increment : ");
> > +     if (str) {
> > +             printk("kernel_hz = %s, ", str);
> > +     } else {
> > +             printk("kernel_hz is unset, ");
> > +     }
> > +     if (!strncmp("100", str, 3)) {
> 
> BTW, if someone enters "kernel_hz=1000", this check (above) for "100"
> matches (detects) 100, not 1000.
> 
ouch. You are right - thanks. I'll be sure to fix that.
I haven't had time to look more at this little thing for the last few
days, but I'll get back to it soon. Thank you for the feedback.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
