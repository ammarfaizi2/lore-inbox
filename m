Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268904AbUHUIfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268904AbUHUIfa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 04:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268900AbUHUIfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 04:35:30 -0400
Received: from qfep04.superonline.com ([212.252.122.160]:13952 "EHLO
	qfep04.superonline.com") by vger.kernel.org with ESMTP
	id S268904AbUHUIfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 04:35:18 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Lee Revell'" <rlrevell@joe-job.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sat, 21 Aug 2004 11:35:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1093076785.854.54.camel@krustophenia.net>
Thread-Index: AcSHWJFuRV0JSUq0Qq205ZHZWmvIGwACI8tQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <S268904AbUHUIfS/20040821083518Z+1953@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Lee Revell [mailto:rlrevell@joe-job.com] 
Sent: Saturday, August 21, 2004 10:26 AM
To: Josan Kadett
Cc: 'Denis Vlasenko'; linux-kernel
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level

On Sat, 2004-08-21 at 05:18, Josan Kadett wrote:
> That is not much of an intelligible idea. A way to hack the kernel could
be
> found as I still presume. "Turn off checksums" but not by re-writing the
> whole tcp code in the kernel. Isn't that possible ? Linux is an operating
> system of infinite possibilities, right ? But only if you know how to hack
> it...
> 

>> Can't you just go into the networking code, and find the part where it
>> checks the checksum, and just have it return success, even if the
>> checksum was bad?  Seems like a quick copy and paste hack.  Am I missing
>> something?

>> Lee


Very well, it is what I really wish to do. The networking code is no simple
issue in linux. As I underlined, two c files, tcp_input.c and udp.c controls
how the checksum is done and the code looks very complicated. Perhaps you
have some idea about where in 100K source code to change in order to disable
checksumming but at the same time not to break normal operation. I can apply
a change in the code, recompile the kernel and test it. I have installed a
virtual machine running linux in order to experiment with the settings, but
the problem is that I do not have enough time to understand what the code is
all about. Perhaps it is in sock.h, perhaps skbuff.h, or any other file.
Each and every file seems to contain some function related to checksumming.






