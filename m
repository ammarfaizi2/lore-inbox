Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWDLKwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWDLKwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 06:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWDLKwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 06:52:49 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:28355 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932150AbWDLKwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 06:52:49 -0400
Date: Wed, 12 Apr 2006 12:51:50 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH 0/19] kconfig patches
In-Reply-To: <20060410142458.1aec19e4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604121232000.32445@scrub.home>
References: <Pine.LNX.4.64.0604091628240.21970@scrub.home>
 <20060409235548.52b563a9.akpm@osdl.org> <Pine.LNX.4.64.0604101035240.32445@scrub.home>
 <20060410005153.2a5c19e2.akpm@osdl.org> <Pine.LNX.4.64.0604101122530.32445@scrub.home>
 <20060410014113.5ba40dd9.akpm@osdl.org> <Pine.LNX.4.64.0604101331030.32445@scrub.home>
 <20060410142458.1aec19e4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Apr 2006, Andrew Morton wrote:

> > and what does update the file the symlink 
> >  points to?
> 
> Me, using oldconfig, menuconfig, etc.  I want those changes to be made in
> the symlinked-to revision-controlled config file.

I see, that makes it indeed a bit more complicated to preserve the 
symlink, I thought you had something to automatically update the .config, 
when you apply/remove patches.
Anyway, as I mentioned in one of the patches, we can start to relax the 
syntax requirements, e.g. we can add something to ignore unknown symbols, 
so you don't have to update the .config all the time, only because a 
config option was added/removed.
I don't want to change the default behaviour yet, but there is now a lot 
of room for experiments, e.g. it's now possible to properly support a 
miniconfig by adding an option to set all unknown symbols to 
n/m/y/default.

bye, Roman
