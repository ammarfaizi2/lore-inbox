Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVGAXgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVGAXgW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVGAXgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:36:22 -0400
Received: from peabody.ximian.com ([130.57.169.10]:28877 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261348AbVGAXgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:36:18 -0400
Subject: Re: [-mm patch] inotify: fsnotify.h: use kstrdup
From: Robert Love <rml@novell.com>
To: Roland Dreier <rolandd@cisco.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <52ekai15bi.fsf@topspin.com>
References: <20050701225559.GC3592@stusta.de>  <52ekai15bi.fsf@topspin.com>
Content-Type: text/plain
Date: Fri, 01 Jul 2005 19:36:16 -0400
Message-Id: <1120260976.7270.23.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-01 at 16:20 -0700, Roland Dreier wrote:
> Why not just convert all calls of fsnotify_oldname_init() to kstrdup()
> and delete the inline function?  The wrapper isn't adding much beyond
> hard-coding GFP_KERNEL.

Good idea, but the function is different if !CONFIG_INOTIFY.  It exists
to save us some ugly ifdefs in the source.

	Robert Love


