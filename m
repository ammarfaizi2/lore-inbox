Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275245AbTHGJeq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 05:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275251AbTHGJeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 05:34:46 -0400
Received: from 066-241-084-054.bus.ashlandfiber.net ([66.241.84.54]:1664 "EHLO
	bigred.russwhit.org") by vger.kernel.org with ESMTP id S275245AbTHGJeo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 05:34:44 -0400
Date: Thu, 7 Aug 2003 02:31:53 -0700 (PDT)
From: Russell Whitaker <russ@ashlandhome.net>
X-X-Sender: russ@bigred.russwhit.org
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.6.0: lp not working
In-Reply-To: <20030806223820.5578d282.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.53.0308070222360.357@bigred.russwhit.org>
References: <20030806130452.722d7fb2.rddunlap@osdl.org>
 <20030806223820.5578d282.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Aug 2003, Randy.Dunlap wrote:

> | Date: Tue, 5 Aug 2003 22:43:17 -0700 (PDT)
> | From: Russell Whitaker <russ@ashlandhome.net>
> | To: linux-kernel@vger.kernel.org
> | Subject: 2.6.0: lp not working
> |
> |
> | Hi
> | Edited lilo.conf so I can boot either kernel-2.6.0-test2
> | (default) or kernel-2.4.21, using hda1.
> |
> | lpr a small file, no print. ctrl-alt-del and rebooted using
> | 2.4.21, file printed. Checked the two config files and could
> | not find any difference in this area.
> |
> | Printer is a Panasonic dot-matrix running in text mode.
> | Also using patch bk5.
>
> Is "Parallel Printer support" built into your kernel or built as a
> module?  If built as a module, are you sure that the module is
> loaded?  If modular, please provide contents of /proc/modules
> when you try to print.
>
Built as a module
Found lp.ko in /lib/modules/2.6.0-test2-bk4/kernel/drivers/char
lp <file> then lpq shows <file> in queue

contents of /proc/modules
ipt_LOG 5376 1 - Live 0xf891a000
ipt_limit 2496 1 - Live 0xf8915000
ipt_state 1792 2 - Live 0xf8913000
iptable_filter 2752 1 - Live 0xf88d3000
ip_tables 22080 4 ipt_LOG,ipt_limit,ipt_state,iptable_filter, Live 0xf88d8000
ip_conntrack_ftp 72308 0 - Live 0xf88fe000
ip_conntrack 43092 2 ipt_state,ip_conntrack_ftp, Live 0xf88df000
ide_cd 41536 0 - Live 0xf88ba000
cdrom 35168 1 ide_cd, Live 0xf88c6000

Hope this helps
  Russ
