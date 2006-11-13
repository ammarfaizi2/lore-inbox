Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754526AbWKMMTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbWKMMTO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 07:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754528AbWKMMTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 07:19:14 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:54982 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1754526AbWKMMTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 07:19:12 -0500
X-Return-Path: <uvsoft@gmail.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BG5FE5Um9LH2gnTdKjV2dsDMykHPJWJ2QhiO/6VY1DgniVaoW10Ybv1ZXJ8ATjakzBLAXKjCX/eUEykkgkBObFIDChEVX0k19/WjVTDqsI7L5GDHRdB3hHM+vnrD7XWvA2Kwt3Ok7Gg75yq4XbeS3UGaa4AFTWsvF4ZMQgUAB3E=
Message-ID: <a5de567c0611130415t6cbe97efr8e60a3d3e091d04d@mail.gmail.com>
Date: Mon, 13 Nov 2006 15:15:26 +0300
From: "Ivan Ukhov" <uvsoft@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: /dev before the root filesystem is mounted
In-Reply-To: <Pine.LNX.4.61.0611131234140.28210@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a5de567c0611130252m52de5071vc25589bfd89b9c27@mail.gmail.com>
	 <Pine.LNX.4.61.0611131234140.28210@yvahk01.tjqt.qr>
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i dont use initrd. the kernel understands argument 'root=/dev/...', so
/dev should exist, mb not in a real filesystem, but just in ram or
something. i just want to know what devices are available for being
the root filesystem for the kernel (displaying all available devices
will be enough for me).

2006/11/13, Jan Engelhardt <jengelh@linux01.gwdg.de>:
>
> > I want the kernel (2.4) to display (just using printk) all available
> > devices with full path (/dev/...) before the root filesystem is
> > mounted.
>
> Case 1: You do not use an initrd/initramfs:
>   / is empty, /dev does not exist.
>
> Case 2: You do use an initrd/initramfs
>   You populated /dev during creation of the initrd/initramfs image OR
>   your init script inside the initrd/initramfs mknods the nodes when run.
>
>
>         -`J'
> --
>
