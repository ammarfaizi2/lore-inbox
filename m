Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVDJRXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVDJRXF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVDJRXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:23:04 -0400
Received: from relay00.pair.com ([209.68.1.20]:1542 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261522AbVDJRXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:23:00 -0400
X-pair-Authenticated: 24.241.238.70
Message-ID: <42596101.3010205@cybsft.com>
Date: Sun, 10 Apr 2005 12:23:13 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc2-V0.7.44-00
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu> <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu>
In-Reply-To: <20050405071911.GA23653@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050407080800060302010209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050407080800060302010209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo,

It would seem that in the latest patch RT-V0.7.45-00 we have reverted 
back to removing the define of jbd_debug which the attached patch 
(against one of the 2.6.11 versions) fixed.

-- 
    kr

--------------050407080800060302010209
Content-Type: text/plain;
 name="jbdfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="jbdfix.patch"

--- linux-2.6.11/include/linux/jbd.h.orig	2005-03-16 09:18:51.000000000 -0600
+++ linux-2.6.11/include/linux/jbd.h	2005-03-16 09:19:24.000000000 -0600
@@ -65,6 +65,7 @@ extern int journal_enable_debug;
 		}							\
 	} while (0)
 #else
+#define jbd_debug(f, a...)   /**/
 #endif
 
 extern void * __jbd_kmalloc (const char *where, size_t size, int flags, int retry);

--------------050407080800060302010209--
