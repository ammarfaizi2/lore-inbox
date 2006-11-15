Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966607AbWKOBRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966607AbWKOBRI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 20:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966609AbWKOBRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 20:17:07 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:24766 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S966607AbWKOBRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 20:17:06 -0500
Message-Id: <200611150117.kAF1H3CD012244@dell2.home>
To: linux-kernel@vger.kernel.org
Subject: RFC  -- /proc/patches to track development 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12177.1163553423.1@dell2.home>
Date: Tue, 14 Nov 2006 20:17:03 -0500
From: "Marty Leisner" <leisner@rochester.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I always want to know WHAT I'm running (or people I'm working with
are running) rather than  "guessing" ("do you have the most current 
patch" "I think so")

I've been a proponent of capturing .config information SOMEPLACE where
you can look at it at runtime...(it took a while but its there now).


In /proc/patches there would be a series of comments (perhaps including
file, date and time) of various patches you want to monitor.  

It would be enabled by something like

in file foo.c:
PATCH_COMMENT("this enables the foo feature");


In membar.c:
PATCH_COMMENT("go to the bar on saturday");
...
PATCH_COMMENT("watch how much you drink");


and in /proc/patches:

foo.c: compiled <date> <time>:this enables the foo feature
membar.c: compiled <date> <time>:go to the bar on saturday
member.c: compiled <date> <time>:watch how much you drink

There would be a Kconfig flag whether or not to enable this (i.e.
production kernels would not need it,
hacked kernels would, it could always be there if you're willing to
increase the footprint).

Instead of looking for aberrant behavior to identify patches, you could easily
see things with cat.

Seems very easy and has high ROI if you need to track patched kernels locally.


marty


