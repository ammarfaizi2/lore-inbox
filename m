Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265916AbUFOULv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbUFOULv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUFOULv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:11:51 -0400
Received: from centaur.culm.net ([83.16.203.166]:48647 "EHLO centaur.culm.net")
	by vger.kernel.org with ESMTP id S265916AbUFOULo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:11:44 -0400
From: Witold Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.6.7] [OOPS] Oops while removing mediabay CD
Date: Tue, 15 Jun 2004 22:10:13 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406152210.13537.adasi@kernel.pl>
X-Spam-Score: -4.3 (----)
X-MIME-Warning: Serious MIME defect detected ()
X-Scan-Signature: d79fd8e265bf02ec8adf6c0257d9bbc2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with not having loaded ide-cd on 2.6.7-rc2:
mediabay0: switching to 7
mediabay0: powering down
media bay 0 is empty
Unregistering mb 0 ide, index:1
devfs_remove: ide/host1/bus0/target0/lun0 not found, cannot remove
Call trace: [c000b244]  [c009b9d8]  [c0117594]  [c0312800]  [c031294c]  
[c000aa84]
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C0097D04 LR: C0098EB0 SP: C1893E50 REGS: c1893da0 TRAP: 0300    Not 
tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000008, DSISR: 40000000
TASK = cbe0ad20[156] 'media-bay' THREAD: c1892000Last syscall: -1
GPR00: C0098EB0 C1893E50 CBE0AD20 00000000 C03418D0 C18AC310 00000000 00000000
GPR08: 00000001 FFFF0001 C0336384 00009032 FFFFFFFA 00000000 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00220000 00230000 C0280000
GPR24: C9C86800 00000001 CBFEE294 00000000 00000001 C0341C40 00000000 C03418D0
Call trace: [c0098eb0]  [c00fc56c]  [c00fc764]  [c00fb134]  [c00fb1b8]  
[c0117510]  [c0312800]  [c031294c]  [c000aa84]
and trying to load ide-cd after that results in hanging it in D+ state...
-- 
Witold Krêcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net
