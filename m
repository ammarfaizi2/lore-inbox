Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbTHSTbG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbTHST3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:29:42 -0400
Received: from mail.webmaster.com ([216.152.64.131]:56575 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261300AbTHST2X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:28:23 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Dumb question: Why are exceptions such as SIGSEGV not logged
Date: Tue, 19 Aug 2003 12:28:19 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEMNFDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <bhs2sb$3fd$1@cesium.transmeta.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 	There is no mechanism that is guaranteed to terminate a
> > process other than
> > sending yourself an exception that is not caught. So in cases
> > where you must
> > guarantee that your process terminates, it is perfectly
> > reasonable to send
> > yourself a SIGILL.

> exit(2)?

	And what if a registered 'atexit' function needs to acquire a mutex that is
held by a thread that's in an endless loop? What if a standard I/O stream
has buffered data for a local disk that failed? I'm looking for a mechanism
that is guaranteed to terminate a process immediately.

	DS


