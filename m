Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135777AbRDYAxq>; Tue, 24 Apr 2001 20:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135778AbRDYAxg>; Tue, 24 Apr 2001 20:53:36 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:6236 "EHLO
	c0mailgw06.prontomail.com") by vger.kernel.org with ESMTP
	id <S135777AbRDYAxZ>; Tue, 24 Apr 2001 20:53:25 -0400
Message-ID: <3AE61FF2.DF9849BB@mvista.com>
Date: Tue, 24 Apr 2001 17:53:06 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Event tools, do they exist
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to look in the wheel locker.

I need a simple event sub system for use in the kernel.  I envision at
least two types of events: the history event and the timing event.

The timing event would keep track of start/stop times by class.  If, for
example, I wanted to know how much time the kernel spends doing the
recalc in schedule() I would put and event start in front of it and an
end at the other end.  The sub system would note the first event time
and the cumulative time between all starts and stops on the same event. 
When reported by /proc/ it would give the total event time, the elapsed
time and the % of processor time for each of the possibly several
classes.

The history event would record each events time, location, data1,
data2.  It would keep N of these (the last N) and report M (M=<N) via
/proc/.  This list should also be kept in a format that a simple
debugger can easily examine.

Somebody must have written these routines and have them in their
library.  Sure would help if I could have a peek.

George
