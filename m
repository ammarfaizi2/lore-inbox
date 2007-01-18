Return-Path: <linux-kernel-owner+w=401wt.eu-S932695AbXARWfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbXARWfx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbXARWfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:35:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49510 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663AbXARWfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:35:52 -0500
Date: Thu, 18 Jan 2007 22:35:50 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       Pierre Peiffer <pierre.peiffer@bull.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, Jakub Jelinek <jakub@redhat.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH 2.6.20-rc5 4/4] sys_futex64 : allows 64bit futexes
Message-ID: <20070118223550.GC5404@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Pierre Peiffer <pierre.peiffer@bull.net>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulrich Drepper <drepper@redhat.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Jean-Pierre Dion <jean-pierre.dion@bull.net>
References: <45ADDF60.5080704@bull.net> <45ADE6B5.8050402@bull.net> <20070118001758.GB17257@infradead.org> <20070118074556.GB29128@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118074556.GB29128@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 08:45:56AM +0100, Ingo Molnar wrote:
> actually, we have a big multiplexer there already, so it's only 
> symmetric. Nothing is served by doing it half-assed. I raised the issue 
> of the multiplexer back when the first futex API was merged (years ago), 
> and it was rejected. Now whether you like it or not we've got to live 
> with that decision. You are certainly free to introduce a patchset with 
> a completely new set of syscall vectors to demultiplex all futex APIs, 
> but to just start a half-done demultiplexing makes zero sense.

dding new syscalls for the old functionality is totally pointless as
we have to support the old entry point forever anyway.  And new code
is using the new entry point, so let's get that right.
