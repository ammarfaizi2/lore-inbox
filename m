Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135779AbRDYA71>; Tue, 24 Apr 2001 20:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135780AbRDYA7Q>; Tue, 24 Apr 2001 20:59:16 -0400
Received: from adsl-63-199-104-197.dsl.lsan03.pacbell.net ([63.199.104.197]:52996
	"HELO ns1.theoesters.com") by vger.kernel.org with SMTP
	id <S135779AbRDYA7G>; Tue, 24 Apr 2001 20:59:06 -0400
From: "Phil Oester" <phil@theoesters.com>
To: <linux-kernel@vger.kernel.org>
Subject: Process start times moving in reverse on 2.4.x
Date: Tue, 24 Apr 2001 17:59:05 -0700
Message-ID: <LAEOJKHJGOLOPJFMBEFEOEJDDGAA.phil@theoesters.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having continual unexplained lockup problems since converting one
of my outgoing qmail servers to 2.4.x.  This has been discussed before on
this list, where the symptoms are that anything typed on console takes
forever to actually come up, and after a few minutes the machine is so
unresponsive it requires a powercycle.

Noticed that when this box is in its state of unresponsiveness, the process
start times in ps gradually move backwards.  The following listings were
taken over about a 1.5 hour timespan.

First
root         1     0  0 11:04 ?        00:00:09 init
root         2     1  0 11:04 ?        00:00:00 [keventd]
root         3     1  0 11:04 ?        00:00:00 [kswapd]
root         4     1  0 11:04 ?        00:00:00 [kreclaimd]
root         5     1  0 11:04 ?        00:00:00 [bdflush]
root         6     1  0 11:04 ?        00:00:02 [kupdated]
root        96     1  0 11:06 ?        00:00:00 [kreiserfsd]
root       356     1  0 11:06 ?        00:00:02 syslogd -m 0
root       366     1  0 11:06 ?        00:00:00 klogd
Second
root         1     0  0 10:54 ?        00:00:09 init
root         2     1  0 10:54 ?        00:00:00 [keventd]
root         3     1  0 10:54 ?        00:00:00 [kswapd]
root         4     1  0 10:54 ?        00:00:00 [kreclaimd]
root         5     1  0 10:54 ?        00:00:00 [bdflush]
root         6     1  0 10:54 ?        00:00:02 [kupdated]
root        96     1  0 10:56 ?        00:00:00 [kreiserfsd]
root       356     1  0 10:56 ?        00:00:02 syslogd -m 0
root       366     1  0 10:56 ?        00:00:00 klogd
Third
root         1     0  0 10:03 ?        00:00:09 init
root         2     1  0 10:03 ?        00:00:00 [keventd]
root         3     1  0 10:03 ?        00:00:00 [kswapd]
root         4     1  0 10:03 ?        00:00:00 [kreclaimd]
root         5     1  0 10:03 ?        00:00:00 [bdflush]
root         6     1  0 10:03 ?        00:00:02 [kupdated]
root        96     1  0 10:06 ?        00:00:00 [kreiserfsd]
root       356     1  0 10:06 ?        00:00:02 syslogd -m 0
root       366     1  0 10:06 ?        00:00:00 klogd
Fourth
root         1     0  0 09:53 ?        00:00:09 init
root         2     1  0 09:53 ?        00:00:00 [keventd]
root         3     1  0 09:53 ?        00:00:00 [kswapd]
root         4     1  0 09:53 ?        00:00:00 [kreclaimd]
root         5     1  0 09:53 ?        00:00:00 [bdflush]
root         6     1  0 09:53 ?        00:00:02 [kupdated]
root        96     1  0 09:55 ?        00:00:00 [kreiserfsd]
root       356     1  0 09:55 ?        00:00:02 syslogd -m 0
root       366     1  0 09:55 ?        00:00:00 klogd


Thoughts?

