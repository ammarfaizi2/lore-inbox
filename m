Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269433AbUHZTnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269433AbUHZTnS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269449AbUHZTjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:39:52 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:21822 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S269336AbUHZTfV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:35:21 -0400
Date: Thu, 26 Aug 2004 21:36:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
       rusty@rustcorp.com.au
Subject: kbuild fixes
Message-ID: <20040826193614.GB9539@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	rusty@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus - please push these fixes.

2 kbuild related fixes:

o kbuild: fix make O=
o kbuild: use lds.* infrastructure in arch/i386/kernel/Makefile

The first one shows up only when using make O= poiting to a fresh directory tree.
The good thing is that it showed that some people actually uses O= ;-)
Thanks to you who reported this issue.

The second one was Rusty deciding to preprocess a lds.S file, in parallel
with me adding the new infrastructure.

Please pull:
	bk pull bk://linux-sam.bkbits.net/kbuild

Patches as follow-up to this mail.

	Sam

