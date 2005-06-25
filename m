Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263363AbVFYHhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263363AbVFYHhg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 03:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbVFYHhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 03:37:36 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:13001 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263363AbVFYHha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 03:37:30 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Kyle Moffett <mrmacman_g4@mac.com>, Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Date: Sat, 25 Jun 2005 10:37:08 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20050624081808.GA26174@kroah.com> <9EE4350F-5791-4787-950B-14E5C2B9ADB8@mac.com>
In-Reply-To: <9EE4350F-5791-4787-950B-14E5C2B9ADB8@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506251037.08506.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 June 2005 03:57, Kyle Moffett wrote:
> One of the things that most annoys me about udev is that I still need
> a minimal static dev in order for the system to boot.  Could something
> like this be used as follows?
> 
> 1)  Boot kernel with an arg "automount_ndevfs", which automounts on /dev
> 
> 2)  Init scripts use console, ttyX, hda, sda, etc from ndevfs

Even more magic piled up in kernel? Please no.

I've moved to initrd-basid start, thus I don't need anything on /dev.
My initrd mounts ramfs on /dev and populates it with bare minimum,
then udev kicks in.

With dietlibc/uclibc/busybox, initrd can get ridiculously small :)
--
vda

