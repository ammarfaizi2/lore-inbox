Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265341AbUF2BnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265341AbUF2BnJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 21:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265343AbUF2BnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 21:43:09 -0400
Received: from imr1.ericy.com ([198.24.6.9]:60549 "EHLO imr1.ericy.com")
	by vger.kernel.org with ESMTP id S265341AbUF2Bm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 21:42:56 -0400
Message-ID: <40E0C907.1040609@ericsson.com>
Date: Mon, 28 Jun 2004 21:42:31 -0400
From: Jon Maloy <jon.maloy@ericsson.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en, fr, de, no, nn, sv, 
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
CC: cgl_discussion <cgl_discussion@osdl.org>,
       tipc <tipc-discussion@lists.sourceforge.net>
Subject: [ANNOUNCE] supporting cluster communication with TIPC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi all,
I would like to announce the availability of TIPC (Transparent Inter 
Process Communication protocol). TIPC is a protocol specially designed 
for high-performance, location transparent communication within 
loosely connected clusters, and has been used successfully in various 
Ericsson products over the last years. 

In cooperation with colleagues from OSDL and Intel, I have ported TIPC 
to Linux,and  rewritten large parts of the code to fit the Linux kernel 
environment and coding requirements. TIPC can be compiled either as a 
part of the kernel or as a loadable module, and is now released as 
open source code under a dual GPL/BSD license. 


Overview
--------
TIPC provides a good support for designing scalable, distributed, 
site independent, highly available, and high-performance applications.

It provides features such as:

o Reliable and unreliable connectionless communication modes: 
  SOCK_RDM and SOCK_DGRAM.
o Reliable connection oriented communication modes: SOCK_SEQPACKET
  and SOCK_STREAM.
o Reliable and unreliable multicast covering the whole cluster.
o 35-80% better performance than TCP/IP for messages < 1.5 kbytes.
  (The tipc-1.2 line).
o A functional addressing scheme that allows primary/secondary key
  addressing and group addressing.
o Ability to adapt to and be carried over different media/protocols, 
  depending on the available network infrastructure and security needs: 
  raw Ethernet, RapidIO, ATM/AAL5, TCP, SCTP, UDP etc.(Only Ethernet 
  supported in the latest version).
o A topology service helping applications to keep track of available 
  functional and physical addresses in the clusters.
  

Implementation Status:
----------------------

There exists two main source code lines:


tipc-1.2.X: this is the most stable and tested release. It works well
            on both Linux 2.4 and Linux 2.6. This code is not compliant 
            with Linux kernel code requirements regarding code style etc,
            and now only has interest for comparative reasons. The 
            corresponding CVS modules are "source/stable_ericsson" and 
            "source/unstable_ericsson". 
            A downloadable example using the API of this version is found
            under "tipc-test", the file "tipc-benchmark-0.93.tar.gz"

tipc-1.3.X: the most recent code, written for Linux 2.6, and compliant with 
            requirements on such code. It works well, but is still slightly 
            less stable than the 1.2 line. The corresponding CVS module is 
            "source/unstable", while we have not had the guts to check in
            anything under "source/stable" yet. We have not been able to 
            verify that this code has the same performance as the 1.2 code, 
            but we have every reason to believe it will be comparable once 
            the proper optimization work is done.
            A downloadable example using the API of this version is found
            under "tipc-test", the file "tipc_test-1.5.tar.gz"


Links:
------
The TIPC page at SourceForge:
http://tipc.sourceforge.net

Downloading source code and documentation:
http://sourceforge.net/projects/tipc/

A draft protocol specification presented at IETF-59 in Seoul last March.
http://www.ietf.org/internet-drafts/draft-maloy-tipc-00.txt

An article written for the April issue of Linux World Magazine:
http://www.linux.ericsson.ca/papers/tipc_lwm/index.shtml

To be presented at OLS in Ottawa next month:
http://www.linux.ericsson.ca/papers/tipc_ols.pdf

We would appreciate your feedback and advice.

Thank you,
Jon Maloy


