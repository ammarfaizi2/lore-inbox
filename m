Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTDGTjU (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 15:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbTDGTjU (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 15:39:20 -0400
Received: from mail.casabyte.com ([209.63.254.226]:58628 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S263597AbTDGTjR (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 15:39:17 -0400
From: "Robert White" <rwhite@casabyte.com>
To: <linux-kernel@vger.kernel.org>
Subject: Stupid API Question.
Date: Mon, 7 Apr 2003 12:50:53 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGGEIHCGAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have looked, but I have not found...

Is there a (safe) Kernel API for setting a processes appearance on the PS
listing? (e.g. it's name etc.)

I have seen the nonsense about clearing out your various argv[] elements and
then using strncpy to replace argv[0].  That seems neither safe nor elegant.
It also seems thread unsafe, or at least thread un-interesting, since all
the threads would be tagged with the same/last such call.

If it exists, where might it be found?


If it doesn't exist...

An API that could change the text for everything after argv[0] and filled a
pointer in the process structure for the process, would be interesting.

I say *after* argv[0] because I think having *any* means to change the
presentation of argv[0] is a far-too-gaping security hole.

I have no idea what the order of magnitude for this effort might be.
Managing a normally-null pointer that overrides the various facts if it is
set, and is freed back into the kernel memory pool when the process exits,
wouldn't be that tough.  Intercepting whatever ps(1) (etc.) does to build
the output might be non-trivial.

Anyway, just a thought...

Rob.

