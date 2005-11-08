Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbVKHV13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbVKHV13 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbVKHV13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:27:29 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:58218 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1030364AbVKHV13
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:27:29 -0500
Date: Tue, 8 Nov 2005 22:28:00 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] slightly enhance cross builds
Message-ID: <20051108212800.GB8256@mars.ravnborg.org>
References: <436F5D96.76F0.0078.0@novell.com> <20051107230426.GD10492@mars.ravnborg.org> <437066EC.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437066EC.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 08:50:52AM +0100, Jan Beulich wrote:
> 
> Though I admit that I never build inside the source tree, I can't see
> what you apparently do. Where/how would the behavior differ? If you just
> mean the fact that in-source-tree builds will need to continue to
> specify ARCH/SUBARCH on the make command line, then of course yes, this
> is going to be different. But building in the source tree is a bad idea
> in general in my opinion, and hence I would view this as the price you
> pay.
That's anyway how most users builds kernel.

> Of course this information could be stored in a hidden file in the
> output tree (rather than in mkmakefile itself) if that's more
> desirable...
Plan has been to add this during *config step to .config.
But I have been sidetracked the few times I looked at it.

Having it as part of *config process is good because
- this is when you configure the kernel
- .config is a natural file to keep configuration within
- and then we have same functionality with and without O=...

	Sam
