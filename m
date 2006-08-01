Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWHAPhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWHAPhf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 11:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWHAPhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 11:37:35 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:11076 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030359AbWHAPhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 11:37:34 -0400
Date: Tue, 1 Aug 2006 17:37:12 +0200
From: Jan-Frode Myklebust <mykleb@no.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] oom_adj/oom_score documentation
Message-ID: <20060801153712.GA2259@99RXZYP.ibm.com>
References: <OFF927B0C7.8C7E4394-ONC12571BC.003A43D2-C12571BC.003B49E8@no.ibm.com> <20060731122314.GL6455@opteron.random> <20060801133323.GA10128@99RXZYP.ibm.com> <20060801134102.GA6455@opteron.random> <20060801141307.GA18159@99RXZYP.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801141307.GA18159@99RXZYP.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got some spelling/language advice from Alan Cox (thanks!), so here's 
an updated patch. Hope it reads better now.


Signed-off-by: Jan-Frode Myklebust <mykleb@no.ibm.com>
 
---

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 99902ae..172098a 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -39,6 +39,8 @@ Table of Contents
   2.9	Appletalk
   2.10	IPX
   2.11	/proc/sys/fs/mqueue - POSIX message queues filesystem
+  2.12	/proc/<pid>/oom_adj - Adjust the oom-killer score
+  2.13	/proc/<pid>/oom_score - Display current oom-killer score
 
 ------------------------------------------------------------------------------
 Preface
@@ -1958,6 +1960,22 @@ a queue must be less or equal then msg_m
 maximum  message size value (it is every  message queue's attribute set during
 its creation).
 
+2.12 /proc/<pid>/oom_adj - Adjust the oom-killer score
+------------------------------------------------------
+
+This file can be used to adjust the score used to select which processes 
+should be killed in an  out-of-memory  situation.  Giving it a high score will 
+increase the likelihood of this process being killed by the oom-killer.  Valid
+values are in the range -16 to +15, plus the special value -17, which disables
+oom-killing altogether for this process.
+
+2.13 /proc/<pid>/oom_score - Display current oom-killer score
+-------------------------------------------------------------
+
+------------------------------------------------------------------------------
+This file can be used to check the current score used by the oom-killer is for
+any given <pid>. Use it together with /proc/<pid>/oom_adj to tune which
+process should be killed in an out-of-memory situation.
 
 ------------------------------------------------------------------------------
 Summary
