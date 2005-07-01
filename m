Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVGAXUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVGAXUz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVGAXUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:20:54 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:60265 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S261345AbVGAXUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:20:51 -0400
X-IronPort-AV: i="3.93,252,1115017200"; 
   d="scan'208"; a="285177671:sNHT25345068"
To: Adrian Bunk <bunk@stusta.de>
Cc: Robert Love <rml@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] inotify: fsnotify.h: use kstrdup
X-Message-Flag: Warning: May contain useful information
References: <20050701225559.GC3592@stusta.de>
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 01 Jul 2005 16:20:49 -0700
In-Reply-To: <20050701225559.GC3592@stusta.de> (Adrian Bunk's message of
 "Sat, 2 Jul 2005 00:55:59 +0200")
Message-ID: <52ekai15bi.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why not just convert all calls of fsnotify_oldname_init() to kstrdup()
and delete the inline function?  The wrapper isn't adding much beyond
hard-coding GFP_KERNEL.

 - R.
