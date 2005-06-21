Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVFUMf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVFUMf2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 08:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVFUMf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:35:28 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:51114 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261417AbVFUMT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:19:26 -0400
Date: Tue, 21 Jun 2005 14:18:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pierre Ossman <drzeus-list@drzeus.cx>
cc: kbuild-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Pointer cast warnings in scripts/
In-Reply-To: <42B7F740.6000807@drzeus.cx>
Message-ID: <Pine.LNX.4.61.0506211413570.3728@scrub.home>
References: <42B7F740.6000807@drzeus.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 21 Jun 2005, Pierre Ossman wrote:

> GCC 4 checks the signedness of pointer casts and generates a whole bunch
> of warnings for code in scripts/ (which makes heavy use of signed char
> strings).
> 
> This patch adds explicit casts.

Just adding explicit all over the place is really the worst solution. 
Check if you can adjust data types/function prototypes.
Lots of the signed stuff was added as a warning fix for Solaris, I'd 
rather drop that than adding casts all over the place. So you also may 
want to check the file history, why certain constructs were added.

bye, Roman
