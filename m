Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUJXLUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUJXLUs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 07:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbUJXLSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 07:18:48 -0400
Received: from av7-2-sn1.fre.skanova.net ([81.228.11.114]:44745 "EHLO
	av7-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261443AbUJXLOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 07:14:20 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] Fix incorrect kunmap_atomic in pktcdvd
References: <m3wtxhibo9.fsf@telia.com> <20041024032546.52314e23.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 24 Oct 2004 13:14:14 +0200
In-Reply-To: <20041024032546.52314e23.akpm@osdl.org>
Message-ID: <m3oeisz7uh.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Peter Osterlund <petero2@telia.com> wrote:
> >
> >  The pktcdvd driver uses kunmap_atomic() incorrectly. The function is
> >  supposed to take an address as the first parameter, but the pktcdvd
> >  driver passed a page pointer. Thanks to Douglas Gilbert and Jens Axboe
> >  for discovering this.
> 
> You're about the 7,000th person to make that mistake.  We really should
> catch it via typechecking but the code's really lame and nobody ever got
> around to rotorooting it.

Why was the interface made different from kmap()/kunmap() in the first
place? Wouldn't it have made more sense to let kunmap_atomic() take a
page pointer as the first parameter?

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
