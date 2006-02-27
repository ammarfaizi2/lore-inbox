Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751735AbWB0TM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbWB0TM3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbWB0TM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:12:29 -0500
Received: from lucidpixels.com ([66.45.37.187]:17126 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751734AbWB0TM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:12:28 -0500
Date: Mon, 27 Feb 2006 14:12:13 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Question regarding call trace.
Message-ID: <Pine.LNX.4.64.0602271411020.5678@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a trace that looks like the following, my question is, are the 
process(es) at the top of the call trace responible for the actual crash 
of the machine?  Are they the root cause?

Would this point to a bad SCSI board?


  Call Trace:    [<c0107a24>] [<c0107b0e>] [<f892ad30>] 
[<c01073f6>] [<f8926590>]
scsi_eh_0     S 00000012  6376   166      1           167    13 (L-TLB)
Call Trace:    [<c0107a24>] [<c0107b0e>] [<c01fffa1>] [<c0108d76>] 
[<c01073f6>]
   [<c01ffc80>]
scsi_eh_1     S 00000010  6372   167      1           168   166 (L-TLB)
Call Trace:    [<c0107a24>] [<c0107b0e>] [<c01fffa1>] [<c0108d76>] 
[<c01073f6>]
   [<c01ffc80>]
scsi_eh_2     S 00000015  6372   168      1           169   167 (L-TLB)
Call Trace:    [<c0107a24>] [<c0107b0e>] [<c01fffa1>] [<c0108d76>] 
[<c01073f6>]
   [<c01ffc80>]
scsi_eh_3     S 00000012  6372   169      1           165   168 (L-TLB)
Call Trace:    [<c0107a24>] [<c0107b0e>] [<c01fffa1>] [<c0108d76>] 
[<c01073f6>]
   [<c01ffc80>]
kjournald     S 00000019  2608   185      1           186   162 (L-TLB)
Call Trace:    [<c0117dfa>] [<c017f6fa>] [<c017f570>] [<c01073f6>] 
[<c017f590>]
kjournald     S 00000019     0   186      1           187   185 (L-TLB)
Call Trace:    [<c0117dfa>] [<c017f6fa>] [<c017f570>] [<c01073f6>] 
[<c017f590>]
kjournald     S 00000016  2608   187      1           188   186 (L-TLB)
Call Trace:    [<c0117dfa>] [<c017f6fa>] [<c017f570>] [<c01073f6>] 
[<c017f590>]
kjournald     S 00000019  2608   188      1           675   187 (L-TLB)
Call Trace:    [<c0117dfa>] [<c017f6fa>] [<c017f570>] [<c01073f6>] 
[<c017f590>]
sshd          S C850FBA0    20   675      1           699   188 (NOTLB)
Call Trace:    [<c0108944>] [<c0117417>] [<c022e480>] [<c015676a>] 
[<c0156af8>]
syslogd08dc3>]R 0000001A  3660   699      1           704

