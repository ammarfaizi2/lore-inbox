Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318794AbSIITav>; Mon, 9 Sep 2002 15:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318852AbSIITav>; Mon, 9 Sep 2002 15:30:51 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:15094 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318794AbSIITau>; Mon, 9 Sep 2002 15:30:50 -0400
Subject: New failures in nightly LTP test
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Sep 2002 14:22:55 -0500
Message-Id: <1031599375.30394.43.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The nightly LTP test against the 2.5 kernel bk tree last night turned up
some test failures we don't normally see.  These failures did not show
up in the run from the previous night.

execve06    0  INFO  :  Test FAILED
getpgid01    0  INFO  :  getpgid01 FAILED
mprotect03    1  FAIL  :  child returned unexpected status

All three are showing warnings that look like this before the failure:
mprotect03    0  WARN  :  signal() failed for signal 41. error:22
Invalid argument.
mprotect03    0  WARN  :  signal() failed for signal 51. error:22
Invalid argument.

The beginning changeset was:
ChangeSet@1.632, 2002-09-08 08:23:34-07:00, ink@jurassic.park.msu.ru
  [PATCH] pci bus resources, transparent bridges

The ending changeset was:
ChangeSet@1.641, 2002-09-08 20:04:56-07:00, mingo@elte.hu
  [PATCH] Re: pinpointed: PANIC caused by dequeue_signal() in current
Linus
 
Any ideas on what may be causing this?

Thanks,
Paul Larson

