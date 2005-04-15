Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVDOSo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVDOSo1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVDOSmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:42:20 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:26545 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261893AbVDOSlA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:41:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=japRbWaK6ClkoRCZg1l6MhCjEgVpCoz2SybHyKNIMrSf+2aAQjxkW7Vcs+csibPkznZOIz8uRTtDrX/0B6l3dwuGkAhN6pb6BVWCJE85a39shDRgvdAsUm5V3ZkQEdFTdk0/4NHAHOneyKy8P9TQHMG7aPi9/h7pOyf1wm7An80=
Message-ID: <e1e1d5f40504151140411a3387@mail.gmail.com>
Date: Fri, 15 Apr 2005 11:40:57 -0700
From: Daniel Souza <thehazard@gmail.com>
Reply-To: Daniel Souza <thehazard@gmail.com>
To: Allison <fireflyblue@gmail.com>
Subject: Re: Kernel Rootkits
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17d79880504151115744c47bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17d79880504151115744c47bd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PS: suckit is not loaded as a kernel module. it uses interrupt gates
to allocate kernel memory and install itself in that memory block,
patching some syscalls and doing other stuffs.

A way to "protect" system calls is, after boot a trusted kernel image,
take a MD5 of the syscalls functions implementations (the opcodes that
are part of sys_read for example) and store it in a secure place. To
verify the integrity of system calls, we can check the current
checksum with the stored ones. Of course, there are other ways to trap
syscalls and hook the system instead of just replace the syscall table
or add JMPs to the start of functions implementation. In that way,
everytime somebody will find another way to trick the system and
bypass this 'protection'.

-- 
# (perl -e "while (1) { print "\x90"; }") | dd of=/dev/evil
