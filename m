Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264956AbUEQKyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbUEQKyU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 06:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbUEQKyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 06:54:20 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:20969 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264956AbUEQKyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 06:54:18 -0400
Date: Mon, 17 May 2004 12:53:24 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, arjanv@redhat.com,
       benh@kernel.crashing.org, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040517105324.GA3695@wohnheim.fh-wedel.de>
References: <20040513145640.GA3430@dreamland.darkstar.lan> <1084488901.3021.116.camel@gaston> <20040513182153.1feb488b.akpm@osdl.org> <20040514094923.GB29106@devserv.devel.redhat.com> <20040514114746.GB23863@wohnheim.fh-wedel.de> <20040514151520.65b31f62.akpm@osdl.org> <20040514155643.G22989@build.pdx.osdl.net> <20040514161814.3e1f690e.akpm@osdl.org> <20040514161904.C21045@build.pdx.osdl.net> <20040514164854.4d81a349.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040514164854.4d81a349.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2004 16:48:54 -0700, Andrew Morton wrote:
> 
> Seems to work.
> 
> .PHONY: checkstack
> checkstack:
> 	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
> 	$(PERL) scripts/checkstack.pl $(ARCH)

Makes sense.

> But we still get a little bit of misparsing:
> 
> 0xc01e37a0 sys_semtimedop:				 sub    $0x1d4,%esp
> 0xc01d1d0f do_udf_readdir:				 sub    $0x1cc,%esp
> 0xc01bbc0c nfs_writepage_sync:				 sub    $0x1b8,%esp
> 0xc02d79c4 snd_mixer_oss_build_input:			 sub    $0x1a4,%esp
> 0xc031c7ec ip_getsockopt:				 sub    $0x194,%esp
> 0xc04c5dc0 snd_seq_oss_midi_lookup_ports:		 sub    $0x190,%esp
> 0xc04c5f88 snd_seq_system_client_init:			 sub    $0x190,%esp
>  4c4:	81 ec 90 01 00 00    	sub    $0x190,%esp snd_virmidi_dev_attach_seq: sub    $0x190,%esp
> 0xc02c1783 snd_ctl_elem_add:				 sub    $0x190,%esp
> 0xc01a715c fat_search_long:				 sub    $0x190,%esp
> 0xc027c2a4 sg_ioctl:					 sub    $0x184,%esp
> 0xc017843c ep_send_events:				 sub    $0x184,%esp

Can you send me your .config for recreation?  This is with -mm2, I
guess.

Jörn

-- 
It's not whether you win or lose, it's how you place the blame.
-- unknown
