Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbUKXMXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbUKXMXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 07:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbUKXMXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 07:23:12 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:13806 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262627AbUKXMXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 07:23:06 -0500
Date: Wed, 24 Nov 2004 11:17:06 +0100
From: bert hubert <ahu@ds9a.nl>
To: Raj <inguva@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Delay in unmounting a USB pen drive
Message-ID: <20041124101706.GA7127@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, Raj <inguva@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <b2fa632f041124012543876b61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2fa632f041124012543876b61@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 02:55:57PM +0530, Raj wrote:
> SuSE kernel 2.6.5:
> 
> My USB pen drive has a vfat FS. When i transfer some files & try to
> unmount the drive ( umount /mnt ) , the command appears hung. CTRL+C also
> does not work. Only later did i realise that it was actually taking a
> longer time ( 10 - 15 sec )
> to unmount.

The data is only actually being written to the pen drive when you unmount.
To make unmounting fast, either mount with -o sync, or run 'sync' before
umounting.


> - Is it safe to remove the pen drive from it's slot when the umount is still in
>   progress ?? ( I tried this the first time & maybe lucky me, the
> files copied were fine )

Try reading them - you will find emtpiness.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
