Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264853AbUFLPct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264853AbUFLPct (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 11:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUFLPcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 11:32:48 -0400
Received: from v2.gawab.com ([204.97.230.42]:28606 "HELO gawab.com")
	by vger.kernel.org with SMTP id S264853AbUFLPcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 11:32:46 -0400
Message-ID: <20040612153247.13279.qmail@gawab.com>
From: "Ramy M. Hassan" <ramy@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: kswapd problem
Date: Sat, 12 Jun 2004 15:32:47 GMT
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [62.114.196.147]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kswapd and kupdated are causing our production server to
completely freezeup for few seconds every now and then.
The server is running kernel 2.4.26SMP on a Dual Xeon 2.20GHz
with 4GB RAM, 900GB FC RAID Qlogic HBA using driver qla2300.o
and reiserfs.
The RAID filesystem contains millions of files in thousands of
directories.
The system is under fair load. Normally the load avarage is
about 3 and everything works properly, but suddenly the system
stops responding except to ping, and stay freezed for about 20
seconds, during that time I can not even type anything, then the
system becomes responsive again and I see the load avarge over
250 and starts to decrease till it is back to 3 , then few
minutes later that same thing is repeated.
I noticed that at the time of the freezups both kswapd and
kupdated are the most active processes each consuming over 30%
of the CPU ( kswapd is usually more than kupdated )

________________________________
15 Mbytes Free Web-based and  POP3
Sign up now: http://www.gawab.com
