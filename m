Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130446AbRDDS3j>; Wed, 4 Apr 2001 14:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130253AbRDDS32>; Wed, 4 Apr 2001 14:29:28 -0400
Received: from mail.ureach.com ([63.150.151.36]:7944 "EHLO ureach.com")
	by vger.kernel.org with ESMTP id <S129464AbRDDS3O>;
	Wed, 4 Apr 2001 14:29:14 -0400
Date: Wed, 4 Apr 2001 14:28:33 -0400
Message-Id: <200104041828.OAA22823@www21.ureach.com>
To: linux-kernel@vger.kernel.org
From: Kapish K <kapish@ureach.com>
Reply-to: <kapish@ureach.com>
Subject: nfs performance at high loads
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-vsuite-type: e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	We have been seeing some problems with running nfs benchmarks
at very high loads and were wondering if somebody could show
some pointers to where the problem lies.
	The system is a 2.4.0 kernel on a 6.2 Red at distribution ( so
nfs utils from 6.2 and the nfsd of 2.4.0 ) - the benchmark run
is the SPECsfs97 benchmarks that runs through a series of the
nfs operations. We have about 4 nfs clients, each invoking the
operations via 8 processes. Everything goes fine till the
500-1000 IOPs mark - no errors, response time is good (0.8
sec/op )and throughput is as expected. But at the 1500 IOPs
mark, errors show up ( nfs operations failure ) and response
time drops to 1.4 Msec/Op. Continue to 2000 IOPs, there is a
drop in the error count and the response time improves  to 1.0
Msec/Op. But from there on, it gets worse, at 2500 IOPs and 3000
IOPs with huge number of nfs errors and finally the nfs server
console scrolls on with an endless number of 'alloc-pages:
0-order allocation failed' and the clients shutdown due to too
many rpc call failures and all that can be done on the server is
to reboot the system as it becomes practically locked for all
purposes.
Any hints or directions to follow or as to whether such a
benchmark testing has been carried out by somebody else for nfs
performance would be very much appreciated.
Thanks,
KK

________________________________________________
Get your own "800" number
Voicemail, fax, email, and a lot more
http://www.ureach.com/reg/tag
