Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbTLKBFb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbTLKBFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:05:31 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51212 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264290AbTLKBEe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:04:34 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: ide-scsi scheduling while atomic in linux-2.6.0-test11
Date: 11 Dec 2003 00:53:13 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <br8f5p$uv7$1@gatekeeper.tmr.com>
References: <3FD6AF84.5010805@samwel.tk>
X-Trace: gatekeeper.tmr.com 1071103993 31719 192.168.12.62 (11 Dec 2003 00:53:13 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3FD6AF84.5010805@samwel.tk>, Bart Samwel  <bart@samwel.tk> wrote:
| [1.] One line summary of the problem:
| 
| ide-scsi scheduling while atomic in linux-2.6.0-test11
| 
| [2.] Full description of the problem/report:
| 
| ide-scsi gives me "scheduling while atomic" while burning a CDRW in 
| linux-2.6.0-test11, when an interrupt is lost. I have no clue what 
| caused this; I was writing a CDRW that might have been faulty, but 
| otherwise nothing unusual. The CDRW is a Samsung SW-408B on the 
| secondary slave. While burning, I was extracting audio data from a CD in 
| the DVD player that was on the secondary master.

I can believe you might have lost an interrupt...
| 
| [3.] Keywords (i.e., modules, networking, kernel):
| 
| ide-scsi, cd-writing
| 
| [4.] Kernel version (from /proc/version):
| 
| Linux version 2.6.0-test11 (root@samwel.tk) (gcc version 3.3.2 (Debian)) 
| #6 Sun Nov 30 22:25:31 CET 2003

Linus posted a patch, which I hope has made it into bk by now, which may
or may not help, but you are better investigating any issue using the
lastest version.
| 
| [5.] Output of Oops.. message (if applicable) with symbolic information
|       resolved (see Documentation/oops-tracing.txt)

	[...snip...]
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
