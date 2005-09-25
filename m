Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbVIYJa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbVIYJa3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 05:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbVIYJa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 05:30:29 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:38286 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1751025AbVIYJa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 05:30:28 -0400
Date: Sun, 25 Sep 2005 11:30:25 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: pfn_valid question
Message-ID: <Pine.LNX.4.53.0509251120340.26494@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to clean up part of the include file mess, I got stuck with
the pfn_valid() macro. For most architectures it is defined in asm/page.h
as well as in asm/mmzone.h, but differently!

It even might be a macro in asm/page.h, but a static inline in
asm/mmzone.h, so that the latter might never be included after the former.
How do we make sure this is always the case?

To me this looks so incredibly fragile that I'm sure I got something
wrong. Who can enlighten me?

thanks,
Tim
