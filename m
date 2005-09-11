Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVIKOyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVIKOyb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 10:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVIKOyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 10:54:31 -0400
Received: from fmr13.intel.com ([192.55.52.67]:16063 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932395AbVIKOya convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 10:54:30 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: new asm-offsets.h patch problems
Date: Sun, 11 Sep 2005 07:54:24 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F045A8E2F@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: new asm-offsets.h patch problems
Thread-Index: AcW2pJy/5UxBgf3gRw6qdHGy+FP8FAAO4CrQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Sep 2005 14:54:27.0282 (UTC) FILETIME=[B4D69B20:01C5B6E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Do you recall why you have this make prepare step. It smells like a
>workaround for a missing dependency somewhere.

There used to be a problem with starting out with "make -j8" ... sometimes
offsets.h hadn't been made before another compilation was started that
needed it.  This may have been fixed at some point, but I wired a
"make prepare" into my scripts to avoid it.

>Tony - can you test below patch and tell it this solve the problem you
>see?
>
>Changes outside top-level Makefile and ia64 Makefile is irellevant for
>you.

I'll try it.  Hunk#2 of the change to Makefile didn't apply with
patch ... I had to apply it by hand.

-Tony
