Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVGUHZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVGUHZf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 03:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVGUHZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 03:25:35 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:26807 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261666AbVGUHZd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 03:25:33 -0400
X-ORBL: [63.202.173.158]
Date: Thu, 21 Jul 2005 00:25:17 -0700
From: Chris Wedgwood <cw@f00f.org>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Jan Blunck <j.blunck@tu-harburg.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
Message-ID: <20050721072517.GA26791@taniwha.stupidest.org>
References: <20050716003952.GA30019@taniwha.stupidest.org> <42DCC7AA.2020506@tu-harburg.de> <20050719161623.GA11771@taniwha.stupidest.org> <42DD44E2.3000605@tu-harburg.de> <20050719183206.GA23253@taniwha.stupidest.org> <42DD50FC.9090004@tu-harburg.de> <20050719191648.GA24444@taniwha.stupidest.org> <20050720112127.GC3890@wohnheim.fh-wedel.de> <20050720181101.GB11609@taniwha.stupidest.org> <20050721072003.GA17431@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050721072003.GA17431@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2005 at 09:20:03AM +0200, J?rn Engel wrote:

> In both cases, what used to be a proper offset in one fd can be
> complete bogus for another one.

Exactly.

Knowing the position within a directory is of questionable value and
trying to implement any reliable semantics for lseek is futile.
