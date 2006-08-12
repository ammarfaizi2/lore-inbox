Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbWHLTff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWHLTff (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 15:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWHLTff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 15:35:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:20075 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932582AbWHLTfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 15:35:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lGxLsWkXvN7Rq3d4CzCVXSOJBQ8L9ZzEC8gr8z45+5tgghrJwyGsALU4aRVw+6XYrL5RZ2/cq9EoHMfjAQefowit+ik88ABoWTUFsSQR74si+EK0sNR5lmlLnpFe2E1E3OCnUDEK+SqA682BVP8KVVGtJpn/7zTtj8n+qmn5V/E=
Message-ID: <9a8748490608121235s6f3830b9yc9ab564599d77d07@mail.gmail.com>
Date: Sat, 12 Aug 2006 21:35:32 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
Subject: Re: RFC : remote driver debugging efforts
Cc: "Om N." <xhandle@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4807377b0608121143k683653b6v47d257adef8a1cca@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6de39a910608102319h76cfe171w1dab7aa700709dcf@mail.gmail.com>
	 <4807377b0608121143k683653b6v47d257adef8a1cca@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/06, Jesse Brandeburg <jesse.brandeburg@gmail.com> wrote:
> On 8/10/06, Om N. <xhandle@gmail.com> wrote:
> > (I do not have a remote power on/off switch. The driver panics so
> > often that somebody has to babysit the machine to switch it off and
> > on. We are in different time zones and things are not moving forward at all)
>
> two (or three) things I've done to help this, when I'm working remotely
>
> add panic=30 to your kernel options in grub (or echo 30 >
> /proc/sys/kernel/panic) to reboot the system automatically on panic.
>
> set grub to automatically boot the safe kernel by default, and when
> making a new kernel, set grub to boot it only once with (say your
> default is 0 and the new kernel is 1 in grub)
>
> echo 'savedefault --default=1 --once' | grub --batch
>
> set up netconsole so that you can see the kernel messages (optional) on oops.
>
> finding out about all these was incredibly hard and obtuse :-)  So
> hope this helps.

If you have remote access to the keyboard/display etc, for example via
a network enabled KVM switch or similar, then magic sysrq can also be
very helpful to remotely sync & unmount filesystems, and do emergency
reboots... It can also be used to get stack dumps etc...  Read
Documentation/sysrq.txt for all the details.

I'm not sure, but I think there was a patch floating around at one
point that would let you trigger sysrq remotely over the network
without even logging into the box or having remote keyboard access -
could be very useful in your case although it is ofcourse extremely
insecure.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
