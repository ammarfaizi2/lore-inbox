Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265323AbTFMKEI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 06:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbTFMKEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 06:04:08 -0400
Received: from angband.namesys.com ([212.16.7.85]:25290 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S265323AbTFMKEG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 06:04:06 -0400
Date: Fri, 13 Jun 2003 14:17:52 +0400
From: Oleg Drokin <green@namesys.com>
To: Martin MOKREJ? <mmokrejs@natur.cuni.cz>
Cc: Linux Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-rc8-acpi-20030522 reiserfs crash
Message-ID: <20030613101752.GA10719@namesys.com>
References: <Pine.OSF.4.51.0306122019060.306698@tao.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.51.0306122019060.306698@tao.natur.cuni.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jun 12, 2003 at 08:37:40PM +0200, Martin MOKREJ? wrote:

>   when trying to stress my laptop and trigger the ECC circuity error caused
> by hdparm turning on DMA under possibly higher load, I did the following:
> $ find / -type f | xargs cp {} /dev/null
> and in the meantime I did :
> # hdparm -d1 /dev/discs/disc0/disc
> dmesg shows:
> vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1640908 1640914 0x0 SD]
> end_request: I/O error, dev 03:02 (hda), sector 45609280
> end_request: I/O error, dev 03:02 (hda), sector 56552
> journal-601, buffer write failed
> The laptop is unusable now, I cannot get another xterm etc. When I close
> remote ssh sessions to use existing shells running in xterms, and do "ls",
> I get permission denied. I had to reset, not ctrl+alt+1, ctrl+alt+backspace

Well, so you cannot read nor write to your disk now, what have you expected from the filesystem in this case?
It serves the stuff that is still in memory, but nothing more than that.

Bye,
    Oleg
