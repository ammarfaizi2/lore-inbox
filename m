Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTFCXDa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 19:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTFCXD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 19:03:29 -0400
Received: from vcgwp1.bit-drive.ne.jp ([211.9.32.211]:422 "HELO
	vcgwp1.bit-drive.ne.jp") by vger.kernel.org with SMTP
	id S261808AbTFCXD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 19:03:27 -0400
To: hardmeter-users@lists.sourceforge.jp
Cc: hyoshiok@miraclelinux.com, perfctr-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: hardmeter 2003-0603 is released
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Cuyahoga Valley)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20030604080102G.hyoshiok@miraclelinux.com>
Date: Wed, 04 Jun 2003 08:01:02 +0900
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

hardmeter 2003-0603, a precise event based sampling (PEBS)
tool, is now available at the following place;
http://sourceforge.jp/projects/hardmeter

2003-06-03  Hiro Yoshioka  <hyoshiok@miraclelinux.com>

        * support perfctr-2.5.4
        * MANIFEST: change patch/perfctr-2.5.4.dif
        * Makefile: change version to 030603
        * patch/perfctr-2.5.4.dif: added
        * update INSTALL and INSTALL.en

---
what is hardmeter

hardmeter is a memory profiling tool using by the performance
monitoring facilities of IA-32 processors.

The tool consists of the following compornent.
 1. Kernel Driver of memory profiling (Linux Kernel Patch)
 2. User Utility (ebs)
 3. User Program API (Application Programming Interface)

Please read the INSTALL.en to install this tool.

* ebs command

You can use ebs command to profile memory traffic. The command syntax
is the following.

Usage: ./ebs (-u | -k) [-o OUTFILE] [-i INTERVAL] [-c COUNT] -t TYPE EXE_OR_PID
  options
    -u           - sample user-mode events
    -k           - sample kernel-mode events
    -o OUTFILE   - store sampled data to file
    -i INTERVAL  - sampling interval(default: 10000)
    -c COUNT     - max sampling count(default: 2000)
    -t TYPE      - event type to sample
    -m NAME,NAME... - event masks
  help options
    -h           - show event types
    -h TYPE      - show event masks

imprecise at-retirement event:
      instr_retired   - instruction retired
      uop_retired     - uops retired
precise front-end event:
      memory_loads    - memory loads
      memory_stores   - memory stores
      memory_moves    - memory loads and stores
precise execution event:
      packed_sp_retired - packed single-precision uop retired
      packed_dp_retired - packed double-precision uop retired
      scaler_sp_retired - scaler single-precision uop retired
      scaler_dp_retired - scaler double-precision uop retired
      64bit_mmx_retired - 64bit SIMD integer uop retired
      128bit_mmx_retired - 128bit SIMD integer uop retired
      x87_fp_retired  - floating point instruction retired
      x87_simd_memory_moves_retired - x87/SIMD store/moves/load uop retired
precise replay event:
      l1_cache_miss   - 1st level cache load miss
      l2_cache_miss   - 2nd level cache load miss
      dtlb_load_miss  - DTLB load miss
      dtlb_stor_miss  - DTLB store miss
      dtlb_all_miss   - DTLB load and store miss
      mob_load_replay_retired - MOB(memory order buffer) causes load replay
      split_load_retired - replayed events at the load port.

Regards,
  Hiro
