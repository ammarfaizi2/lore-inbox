Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270977AbTG1W3H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 18:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271120AbTG1W3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 18:29:07 -0400
Received: from aneto.able.es ([212.97.163.22]:14780 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S270977AbTG1W3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 18:29:02 -0400
Date: Tue, 29 Jul 2003 00:28:53 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: "Feldman, Scott" <scott.feldman@intel.com>
Subject: e1000 performance
Message-ID: <20030728222853.GA2446@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I think I am getting weird performace with e1000 in 2.4.22-pre.
NetPipe gives this numbers for e1000:

Node receiver...
Master transmitter...
Latency: 0.000040
Now starting main loop
  0:      4096 bytes    7 times -->  264.18 Mbps in 0.000118 sec
  1:      8192 bytes    7 times -->  397.55 Mbps in 0.000157 sec
  2:     12288 bytes  795 times -->  475.30 Mbps in 0.000197 sec
  3:     16384 bytes  845 times -->  524.12 Mbps in 0.000238 sec
  4:     20480 bytes  786 times -->  566.84 Mbps in 0.000276 sec
  5:     24576 bytes  725 times -->  586.49 Mbps in 0.000320 sec
  6:     28672 bytes  651 times -->  605.81 Mbps in 0.000361 sec
  7:     32768 bytes  593 times -->  618.25 Mbps in 0.000404 sec
  8:     36864 bytes  540 times -->  579.82 Mbps in 0.000485 sec
  9:     40960 bytes  458 times -->  579.72 Mbps in 0.000539 sec
 10:     45056 bytes  417 times -->  565.82 Mbps in 0.000608 sec
 11:     49152 bytes  374 times -->  569.07 Mbps in 0.000659 sec
 12:     53248 bytes  347 times -->  576.62 Mbps in 0.000705 sec
 13:     57344 bytes  327 times -->  584.06 Mbps in 0.000749 sec
 14:     61440 bytes  309 times -->  587.31 Mbps in 0.000798 sec
 15:     65536 bytes  292 times -->  592.25 Mbps in 0.000844 sec
 16:     69632 bytes  277 times -->  577.42 Mbps in 0.000920 sec
 17:     73728 bytes  255 times -->  566.39 Mbps in 0.000993 sec
 18:     77824 bytes  237 times --> 

Hardware:
03:01.0 Ethernet controller: Intel Corp. 82543GC Gigabit Ethernet Controller (Copper) (rev 02)

Kernel is 2.4.22-pre8, patch for MMX/SSE checksums applied:
Measuring network checksumming speed
   basic     :   768.000 MB/sec
   simple    :   665.600 MB/sec
func 3Dnow! skipped: not supported by CPU
func AMD-MMX skipped: not supported by CPU
   SSE1+     :   819.200 MB/sec
csum: using csum function: SSE1+
   basic     :   537.600 MB/sec
   simple    :   537.600 MB/sec
func AMD-MMX skipped: not supported by CPU
   SSE1+     :   588.800 MB/sec
   SSE1      :   691.200 MB/sec
csum: using csum_copy function: SSE1

No modules parameters for e1000 (default behaviour), no mtu changes, nothing.

Any ideas to up performance ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre8-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.6mdk))
