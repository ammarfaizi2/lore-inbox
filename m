Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265619AbUAMWwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265820AbUAMWuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:50:11 -0500
Received: from magic-mail.adaptec.com ([216.52.22.10]:60124 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S266254AbUAMWqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:46:00 -0500
Message-ID: <400474D6.30705@adaptec.com>
Date: Tue, 13 Jan 2004 15:44:38 -0700
From: Scott Long <scott_long@adaptec.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.4) Gecko/20030817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?SnVyZSBQZcSNYXI=?= <pegasus@nerv.eu.org>
CC: jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: Proposed enhancements to MD
References: <20040113233320.23e4cfef.pegasus@nerv.eu.org>
In-Reply-To: <20040113233320.23e4cfef.pegasus@nerv.eu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jure Pečar wrote:
> On Tue, 13 Jan 2004 13:41:07 -0700
> Scott Long <scott_long@adaptec.com> wrote:
> 
> 
>>A problem that we've encountered, though, is the following sequence:
>>
>>1) md is inialized during boot
>>2) drives X Y and Z are probed during boot
>>3) root fs exists on array [X Y Z], but md didn't see them show up,
>>    so it didn't auto-configure the array
>>
>>I'm not sure how this can be addressed by a userland daemon.  Remember
>>that we are focused on providing RAID during boot; configuring a
>>secondary array after boot is a much easier problem.
> 
> 
> Looking at this chicken-and-egg problem of booting from an array from
> administrator's point of view ...
> 
> What do you guys think about Intel's EFI? I think it would be the most
> apropriate place to put a piece of code that would scan the disks,
> assemble
> any arrays and present them to the OS as bootable devices ... If we're
> going
> to get a common metadata layout, that would be even easier.
> 
> Thoughts?
> 

The BIOS already scans the disks, assembles the arrays, and presents
finds the boot sector, and presents the arrays to the loader/GRUB.  Are
you saying that EFI should be the interface by which the arrays are
communicated through, even after the kernel has booted?  Is this
possible right now?

Scott

