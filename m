Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318194AbSHIIpv>; Fri, 9 Aug 2002 04:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318196AbSHIIpv>; Fri, 9 Aug 2002 04:45:51 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:9892 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S318194AbSHIIpt> convert rfc822-to-8bit; Fri, 9 Aug 2002 04:45:49 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: SA <bullet.train@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: device driver / char module interrupt vector -> user space code
Date: Fri, 9 Aug 2002 09:49:48 +0100
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208090949.48484.bullet.train@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Kernel List,

I am writing a char module for a PCI stage controller and want to add the 
following functionality; 

The device will generate an interrupt (or software trigger) and I want this to 
run a bit of user code with relatively latency.  (<1ms).  I am unclear how to
do this while still separating the user from the kernel code and maintaining
security - would this usually be handled by issuing a signal to the user space
process? if so how and what latency can I expect? 

Thanks matt


(more info: the stage controller moves little mechanical platforms in an 
experiment, as the platforms reach certain positions (determined by
the hardware or the driver) user code must be run to perform some
action (say take a measurement).  The stages move continuously so
timing errors map to positional errors.  I could do all this in kernel space
by linking the various drivers controlling the various hardware together
under a super-driver for the entire experiment, however, it would be
much nicer to achieve this with separate modules and user code). 
