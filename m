Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbWGAJjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWGAJjg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 05:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWGAJjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 05:39:36 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:54465 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932554AbWGAJjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 05:39:36 -0400
Date: Sat, 1 Jul 2006 11:39:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Milton Miller <miltonm@bga.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [KBUILD] allow any PHONY in if_changed_dep
Message-ID: <20060701093927.GA25738@mars.ravnborg.org>
References: <200607010916.k619GuxT005076@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607010916.k619GuxT005076@sullivan.realtime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2006 at 04:16:56AM -0500, Milton Miller wrote:
> While all the if_changed family filter $(PHONY) from the list of newer
> files, if_changed_dep was only filtering FORCE from the list of all
> dependents.  This resulted in forced recompile every time.

I see where you are heading with this. But on the principle of minimal
suprise this is not good. Why does it not include file.o in the link
when I mark it phony?

The root cause is buried in the powerpc/boot/Makefile restructuring.
I do not see what is wrong with current approch if you do a simple
s/cmd/if_changed/g and then assign targets += <relevant targets>

You need to post a full diff of the Makefile before I can give better
feedback.

	Sam
