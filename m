Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUDONrd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 09:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbUDONrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 09:47:33 -0400
Received: from webmail2.speakeasy.net ([216.254.0.82]:6026 "EHLO
	webmail.speakeasy.net") by vger.kernel.org with ESMTP
	id S263868AbUDONr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 09:47:29 -0400
From: ward@speakeasy.net
To: fedora-test-list@redhat.com
Cc: linux-kernel@vger.kernel.org
Importance: Normal
Sensitivity: Normal
Message-ID: <W3421210850157201082036847@webmail2>
X-Mailer: Mintersoft VisualMail, Build 4.0.111601
X-Originating-IP: [199.196.144.16]
Date: Thu, 15 Apr 2004 13:47:27 +0000
Subject: FC2T2 shared memory segments cannot be allocated by DB2 V8.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running into regular memory related issues with a Fedora Core 2 system
which appears to have been properly configured using generous sysctl.conf
settings.

The symptoms are that I can create a limited number of connections to unique
databases running on this development system and then after about the fifth or
sixth I encounter an error indicating a failure to allocate shared memory
segments.

Running ipcs -m at the time of the error I can see 8 shared memory segments
owned by that userid and 32 total on the system. ipcs -l indicates the
settings I've made to sysctl.conf...

------ Shared Memory Limits --------
max number of segments = 4096
max seg size (kbytes) = 1048576
max total shared memory (kbytes) = 8388608
min seg size (bytes) = 1

The database engine indicates this error in its logs as an occurance of a
Memory allocation failure.

Unsure if this was related to a similar issue which impacts Oracle I explored
various combinations of kernels and patches including support for the patch
to add a sysctl capability to control the disable_cap_mlock feature.

Note that after the occurance of a failure I'm experiencing problems with
the forking of processes. This was seen in kernel compiles and while halting
the system.

Any ideas?


