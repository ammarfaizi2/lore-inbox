Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266476AbUA2Wqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 17:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUA2Wqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 17:46:51 -0500
Received: from grebe.mail.pas.earthlink.net ([207.217.120.46]:53167 "EHLO
	grebe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S266476AbUA2Wqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 17:46:50 -0500
Message-ID: <01c501c3e6b9$67225f70$0700000a@irrosa>
From: "Curt Hartung" <curt@northarc.com>
To: <linux-kernel@vger.kernel.org>
Subject: Raw devices broken in 2.6.1?
Date: Thu, 29 Jan 2004 17:44:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New to the list, checked the FAQ and nothing on this. I'm using raw devices
for a large database application (highwinds-software) and under 2.4 it runs
fine, but under 2.6 I get: Program terminated with signal 25, File size
limit exceeded. (SIGXFSZ) As soon as it tries to grow the raw device pase 2G
(might be 4G, I'll go back and check)

ulimit reports: file size (blocks)          unlimited
but running the process as root and setrlimit RLIMIT_FSIZE to RLIM_INFINITY
just to be sure yields the same result.

I can easily provide a short test program to trigger it, the call I'm using
is pwrite64(...);

-Curt

