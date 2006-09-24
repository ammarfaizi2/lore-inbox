Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWIXRkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWIXRkW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 13:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWIXRkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 13:40:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:24752 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751313AbWIXRkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 13:40:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G7LCuUWrvMzoxQSRi5GkbN5ebnxbBKZAGLKrX8V20m0iB/0lBeF50w6wbkgzQj++HdsaHpn454vyAS0LVkjFUQLSUnSH50uBtIrUvDnyzMVICuBvMRi1PtcuYiGuntPvtak+JYRS5HFtQ60XAFOEkEpryd+hB8gF1pj0XzFwbCU=
Message-ID: <fbf7c10b0609241040j10bef8a0qce1d95d8cd98f981@mail.gmail.com>
Date: Sun, 24 Sep 2006 13:40:19 -0400
From: "Ryan Moszynski" <ryan.m.lists@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: /drivers/usb/class/cdc-acm.c patch question, please cc
Cc: "Oliver Neukum" <oliver@neukum.org>, "David Kubicek" <dave@awk.cz>,
       greg@kroah.com
In-Reply-To: <200609241526.48659.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fbf7c10b0609221445q1329eb5bsfe304c02f7f336db@mail.gmail.com>
	 <200609241526.48659.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry guys, my bad.

I just compiled 2.6.18 again with my stock config, and everything
worked. With 2.6.15 i had to recompile using the patch and load these
in /etc/modules in order for my card to work at full speed.

######
ohci-hcd
usbserial vendor=0x0c88 product=0x17da maxSize=2048
cdc_acm maxszr=16384 maxszw=2048
#######

however, now, at boot the kernel loads the 'airprime' driver, and
everything works without any manual module loading.  Yay.  2.6.15 had
the airprime driver, but i guess it didn't recognize my card at that
point.

However, to get this(and i would guess any other evdo) card to work,
you still have set up 4 config files:

######
etc/ppp/chap-secrets
etc/ppp/peers/verizon
etc/chatscripts/verizon-connect
etc/chatscripts/verizon-disconnect
#######

which makes it a lot more labor intensive to set up for the first time
than it is in windows, but at least everything works.



On 9/24/06, Oliver Neukum <oliver@neukum.org> wrote:
> Am Freitag, 22. September 2006 23:45 schrieb Ryan Moszynski:
> > since 2.6.14 i have been applying the following patch and recompiling
> > my kernel so
> > that i can use my verizon kpc650 evdo card with my laptop. I've
> > applied this patch
> > succesfully on 2.6.14 and 2.6.15. It works great and I have no problems. I am
> > trying to apply the patch to 2.6.18 but it fails, and i don't want to
> > break anything,
>
> First give me a description of your device. Secondly, we'll try
> to find a generic solution. Thirdly, if nothing else helps, we'll add
> a generic quirk to the driver.
>
>         Regards
>                 Oliver
>
