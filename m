Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318929AbSHEXDF>; Mon, 5 Aug 2002 19:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318930AbSHEXDE>; Mon, 5 Aug 2002 19:03:04 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:28086 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S318929AbSHEXDE>; Mon, 5 Aug 2002 19:03:04 -0400
Message-ID: <3D4F0403.B136A031@us.ibm.com>
Date: Mon, 05 Aug 2002 18:02:27 -0500
From: Duc Vianney <dvianney@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       mcao@us.ibm.com, bhartner@us.ibm.com
Subject: IPC lock patch performance improvement
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran the LMbench Pipe and IPC latency test bucket against the IPC lock
patch from Mingming Cao and found the patch improves the performance of
those functions from 1% to 9%. See the attached data. The kernel under
test is 2.5.29, SMP kernel running on a 4-way 500 MHz. The data for
2.5.29s4-ipc represents the average of three runs.

                                                           Percent
                                  2.5.29s4 2.5.29s4-ipc Improvement
Pipe latency                         12.51     11.43         9%
AF_Unix sock stream latency          21.61     19.82         8%
UDP latency using localhost          36.28     35.12         3%
TCP latency using localhost          56.90     54.89         4%
RPC/tcp latency using local host    123.30    121.91         1%
RPC/udp latency using localhost      89.78     88.70         1%
TCP/IP connection cost to localhost 192.74    187.76         3%
Note: Latency is in microseconds
Note: 2.5.29s4 is the base 2.5.29 SMP kernel running on a 4-way,
2.5.29s4-ipc is the base 2.5.29 SMP kernel built with IPC lock patch.

Duc. dvianney@us.ibm.com

