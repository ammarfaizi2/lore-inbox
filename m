Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318107AbSHDILb>; Sun, 4 Aug 2002 04:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318122AbSHDILb>; Sun, 4 Aug 2002 04:11:31 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:60511 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S318107AbSHDILa>; Sun, 4 Aug 2002 04:11:30 -0400
Date: Sun, 4 Aug 2002 11:14:53 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.5.30: buffer layer error at page-writeback.c:417
Message-ID: <20020804081452.GC1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
References: <200208020726.51659.tomlins@cam.org> <20020803190734.GB1548@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020803190734.GB1548@niksula.cs.hut.fi>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

buffer layer error at page-writeback.c:417
Pass this trace through ksymoops for reporting
c11e7e10 000001a1 c3d1bc20 c108e458 c3d1bc20 c108e458 c11e7e38 c012a2db
       c108e458 c108e460 c11e7e88 c0159ae9 c108e458 c335c68c c11e7e9c c0165a46
       c335c68c c11e6000 c11e6000 c11e6000 c3d1bc48 c3d1bc38 c012a280 00000000
Call Trace: [<c012a2db>] [<c0159ae9>] [<c0165a46>] [<c012a280>] [<c0139697>]
   [<c015891d>] [<c0158c8a>] [<c0158dd4>] [<c0158e57>] [<c013958d>] [<c0139178>]
   [<c01391b0>] [<c01391c1>] [<c0139530>] [<c010769d>]

Trace; c012a2db <fail_writepage+5b/70>
Trace; c0159ae9 <mpage_writepages+269/310>
Trace; c0165a46 <ext2_free_blocks+146/370>
Trace; c012a280 <fail_writepage+0/70>
Trace; c0139697 <do_writepages+37/40>
Trace; c015891d <__sync_single_inode+ad/1f0>
Trace; c0158c8a <sync_sb_inodes+16a/240>
Trace; c0158dd4 <__writeback_unlocked_inodes+74/d0>
Trace; c0158e57 <writeback_unlocked_inodes+27/30>
Trace; c013958d <wb_kupdate+5d/a0>
Trace; c0139178 <__pdflush+1f8/230>
Trace; c01391b0 <pdflush+0/20>
Trace; c01391c1 <pdflush+11/20>
Trace; c0139530 <wb_kupdate+0/a0>
Trace; c010769d <kernel_thread_helper+5/18>


-- v --

v@iki.fi
