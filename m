Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWFSS4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWFSS4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWFSS4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:56:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36580 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964841AbWFSS4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:56:52 -0400
Date: Mon, 19 Jun 2006 19:56:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 5/8] inode-diet: Eliminate i_blksize and use a per-superblock default
Message-ID: <20060619185651.GB15389@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Tso <tytso@mit.edu>, linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <20060619153109.817554000@candygram.thunk.org> <20060619155821.GA27867@infradead.org> <20060619170338.GB15216@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619170338.GB15216@thunk.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 01:03:38PM -0400, Theodore Tso wrote:
> I was mainly adding a field to the superblock for the sake of
> reiserfs; it was the easiest way to support it's current insanity of
> reporting 128megs as st_blksize, but with a mount option that affected
> things on a global scale.  (Hey, at least my patch made resierfs
> support the mount option as a per-superblock setting, instead of
> setting a global variable that changed the behaviour for all mounts.)
> 
> I don't mind espceially removing the superblock field, but if we do, I
> refuse to mess with adding a getattr special for reiserfs; someone who
> wants to support its current behaviour is free to send me or LKML
> patches....

I'd suggest to either keep their current buggy behaviour and let Hans fix
it or use a field in the reiserfs specific superblock structure.
