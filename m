Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWHLSnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWHLSnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 14:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWHLSnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 14:43:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:14510 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932582AbWHLSnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 14:43:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NPZmEebnrx1qoM2glz+WTlwFPRKJITIy6y7yq2P8wSE7jpE2lPsFRv9LGnbJ083ginsH+eoc3ybT9fliCSEUSXcwe1izqGAlYDumW6WC+u51mCkpB9ZJ+3m0OKebiShNagzwZvwPPR3HvXmYBPH9jCL5eIE87KxURyxbfEbJAZY=
Message-ID: <4807377b0608121143k683653b6v47d257adef8a1cca@mail.gmail.com>
Date: Sat, 12 Aug 2006 11:43:13 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Om N." <xhandle@gmail.com>
Subject: Re: RFC : remote driver debugging efforts
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6de39a910608102319h76cfe171w1dab7aa700709dcf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6de39a910608102319h76cfe171w1dab7aa700709dcf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/06, Om N. <xhandle@gmail.com> wrote:
> (I do not have a remote power on/off switch. The driver panics so
> often that somebody has to babysit the machine to switch it off and
> on. We are in different time zones and things are not moving forward at all)

two (or three) things I've done to help this, when I'm working remotely

add panic=30 to your kernel options in grub (or echo 30 >
/proc/sys/kernel/panic) to reboot the system automatically on panic.

set grub to automatically boot the safe kernel by default, and when
making a new kernel, set grub to boot it only once with (say your
default is 0 and the new kernel is 1 in grub)

echo 'savedefault --default=1 --once' | grub --batch

set up netconsole so that you can see the kernel messages (optional) on oops.

finding out about all these was incredibly hard and obtuse :-)  So
hope this helps.
