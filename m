Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSGUMFo>; Sun, 21 Jul 2002 08:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSGUMFo>; Sun, 21 Jul 2002 08:05:44 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:44671 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S313867AbSGUMFn>; Sun, 21 Jul 2002 08:05:43 -0400
Date: Sun, 21 Jul 2002 15:08:37 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.5.26 buffer layer error at page-writeback.c:420
Message-ID: <20020721120837.GJ1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just booted 2.5.26 to textmode, logged in as root and left it there. After
a while I got this. After that, floppy access etc fails.

buffer layer error at page-writeback.c:420
Pass this trace through ksymoops for reporting
c11f9e5c 000001a4 c3f06f20 c1080720 c3f06f20 c3f06f48 c11f9e84 c012775e 
       c1080720 c1080720 c11f9ec4 c0151ea4 c1080720 00000000 c011ce66
00000001 
       c11f9eac c3f06f38 c0127700 00000000 00000000 00000000 00000000
c3f06ea0 
Call Trace: [<c012775e>] [<c0151ea4>] [<c011ce66>] [<c0127700>] [<c0135710>] 
   [<c0150fd9>] [<c0151268>] [<c01513ac>] [<c013561d>] [<c01352bd>]
[<c0105000>] [<c01352f1>] [<c01355c0>] [<c01075fe>] [<c01352e0>] 
buffer layer error at page-writeback.c:432
Pass this trace through ksymoops for reporting
c11f9e5c 000001b0 c3f06f20 c1080720 c3f06f20 c3f06f48 c11f9e84 c012775e 
       c1080720 c1080720 c11f9ec4 c0151ea4 c1080720 00000000 c011ce66
00000001 
       c11f9eac c3f06f38 c0127700 00000000 00000000 00000000 00000000
c3f06ea0 
Call Trace: [<c012775e>] [<c0151ea4>] [<c011ce66>] [<c0127700>] [<c0135710>] 
   [<c0150fd9>] [<c0151268>] [<c01513ac>] [<c013561d>] [<c01352bd>]
[<c0105000>]
   [<c01352f1>] [<c01355c0>] [<c01075fe>] [<c01352e0>] 

ksymoops:
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c012775e <fail_writepage+5e/70>
Trace; c0151ea4 <mpage_writepages+1d4/260>
Trace; c011ce66 <update_wall_time+16/40>
Trace; c0127700 <fail_writepage+0/70>
Trace; c0135710 <generic_writepages+20/30>
Trace; c0150fd9 <__sync_single_inode+89/1b0>
Trace; c0151268 <sync_sb_inodes+e8/1d0>
Trace; c01513ac <writeback_unlocked_inodes+5c/60>
Trace; c013561d <wb_kupdate+5d/a0>
Trace; c01352bd <__pdflush+19d/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c01352f1 <pdflush+11/20>
Trace; c01355c0 <wb_kupdate+0/a0>
Trace; c01075fe <kernel_thread+2e/40>
Trace; c01352e0 <pdflush+0/20>
Trace; c012775e <fail_writepage+5e/70>
Trace; c0151ea4 <mpage_writepages+1d4/260>
Trace; c011ce66 <update_wall_time+16/40>
Trace; c0127700 <fail_writepage+0/70>
Trace; c0135710 <generic_writepages+20/30>
Trace; c0150fd9 <__sync_single_inode+89/1b0>
Trace; c0151268 <sync_sb_inodes+e8/1d0>
Trace; c01513ac <writeback_unlocked_inodes+5c/60>
Trace; c013561d <wb_kupdate+5d/a0>
Trace; c01352bd <__pdflush+19d/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c01352f1 <pdflush+11/20>
Trace; c01355c0 <wb_kupdate+0/a0>
Trace; c01075fe <kernel_thread+2e/40>
Trace; c01352e0 <pdflush+0/20>

 
-- v --

v@iki.fi
