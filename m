Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbUKXRgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbUKXRgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbUKXRea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:34:30 -0500
Received: from [213.146.154.40] ([213.146.154.40]:52706 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262765AbUKXRXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:23:07 -0500
Date: Wed, 24 Nov 2004 16:56:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Phil Dier <phil@dier.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm, and xfs
Message-ID: <20041124165658.GA16800@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Phil Dier <phil@dier.us>, linux-kernel@vger.kernel.org
References: <20041122130622.27edf3e6.phil@dier.us> <20041122161725.21adb932.akpm@osdl.org> <20041124094549.4c51d6d5.phil@dier.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124094549.4c51d6d5.phil@dier.us>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 09:45:49AM -0600, Phil Dier wrote:
> Looks like 8k stacks did the trick, at least for the oops. Now I'm
> seeing the stuff below.
> 
> I got a ton more of this with jfs and xfs, but it seems much less with
> reiser. Should I be worried, or is this something I can safely ignore?
> It doesn't lock the system..  Could files be getting corrupted?
> 
> 
> Nov 23 17:38:20 calculon swapper: page allocation failure. order:0, mode:0x20

This is pretty harmless.  It just means the NIC driver couldn't allocate as
much memory in the RX path as it wanted.  Try increasing
/proc/sys/vm/min_free_kbytes to make the warnings go away and get less packet
drops

