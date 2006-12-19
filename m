Return-Path: <linux-kernel-owner+w=401wt.eu-S1754767AbWLSLTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbWLSLTW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 06:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754800AbWLSLTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 06:19:22 -0500
Received: from mail.gdatech.co.in ([202.144.30.226]:48819 "EHLO gdatech.co.in"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754767AbWLSLTU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 06:19:20 -0500
X-Propel-Return-Path: <n.balaji@gdatech.co.in>
Message-ID: <48805.202.144.30.226.1166527442.squirrel@mail.gdatech.co.in>
Date: Tue, 19 Dec 2006 16:54:02 +0530 (IST)
Subject: Asynchronous Crypto suppor for MPC8360E's Security Engine
From: n.balaji@gdatech.co.in
To: "David McCullough" <david_mccullough@au.securecomputing.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
       n.balaji@gdatech.co.in
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Priority: 3
Importance: Normal
References: 
In-Reply-To: 
Content-Transfer-Encoding: 7BIT
X-Propel-ID: r6cj031918-02-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I am working on MPC8360E Security Engine. I have ported the Openswan
2.4.5(IPSec --KLIPS) with OCF to MPC8360E's Security Engine (Talitos).
Encryption and Decryption is working. But when I check the performance of
Talitos with netio benchmark Tool, IPSec S/W Algorithms is giving more
bandwidth than Talitos.
  I do not know that why Talitos is giving less bandwidth and any probelm
in Openswan or OCF or Talitos driver or Talitos H/W. Please give your
suggestions and if you have any link related to Talitos, send to me.

  Linux kernel version is 2.6.11.

  We tested the IPSec performance by netio tool. The output is

Without IPSec :
-------------
Packet size  1k bytes:  8735 KByte/s Tx,  11242 KByte/s Rx.
Packet size  2k bytes:  8723 KByte/s Tx,  11001 KByte/s Rx.
Packet size  4k bytes:  8730 KByte/s Tx,  10159 KByte/s Rx.
Packet size  8k bytes:  8762 KByte/s Tx,  10986 KByte/s Rx.
Packet size 16k bytes:  8725 KByte/s Tx,  10997 KByte/s Rx.
Packet size 32k bytes:  8725 KByte/s Tx,  11002 KByte/s Rx.

IPSec in S/W :
------------
Packet size  1k bytes:  884 KByte/s Tx,  1120 KByte/s Rx.
Packet size  2k bytes:  1234 KByte/s Tx,  1149 KByte/s Rx.
Packet size  4k bytes:  1209 KByte/s Tx,  1178 KByte/s Rx.
Packet size  8k bytes:  885 KByte/s Tx,  1155 KByte/s Rx.
Packet size 16k bytes:  1184 KByte/s Tx,  1197 KByte/s Rx.
Packet size 32k bytes:  1194 KByte/s Tx,  1206 KByte/s Rx.

IPSec in H/W :
-------------
Packet size  1k bytes:  55978 Byte/s Tx,  484 KByte/s Rx.
Packet size  2k bytes:  57685 Byte/s Tx,  577 KByte/s Rx.
Packet size  4k bytes:  57344 Byte/s Tx,  812 KByte/s Rx.
Packet size  8k bytes:  58709 Byte/s Tx,  438 KByte/s Rx.
Packet size 16k bytes:  60074 Byte/s Tx,  627 KByte/s Rx.
Packet size 32k bytes:  60072 Byte/s Tx,  575 KByte/s Rx.

 We sholud get more bandwidth when we test through IPSec H/W. But We are
getting less bandwidth compare to IPSec S/W.

 But When we transmit 32 MB size file through tftp, it is transmitted in
139.0 seconds in IPSec S/W. When we transmit the same file, it is
transmitted in 136.2 seconds.

 When we ping the system, we got the reply in 2ms in IPSec S/W and 1ms in
IPSec H/W.

-Thanks
 N.Balaji










