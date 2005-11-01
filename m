Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbVKAEu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbVKAEu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbVKAEu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:50:28 -0500
Received: from THUNK.ORG ([69.25.196.29]:35748 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964934AbVKAEu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:50:28 -0500
Date: Mon, 31 Oct 2005 23:46:58 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Adrian Bunk <bunk@stusta.de>, ext2-devel@lists.sourceforge.net,
       sct@redhat.com, akpm@osdl.org, ext3-users@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: What is the history of CONFIG_EXT{2,3}_CHECK?
Message-ID: <20051101044658.GA7500@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Adrian Bunk <bunk@stusta.de>, ext2-devel@lists.sourceforge.net,
	sct@redhat.com, akpm@osdl.org, ext3-users@redhat.com,
	linux-kernel@vger.kernel.org
References: <20051031001334.GP4180@stusta.de> <20051031212503.GY31368@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031212503.GY31368@schatzie.adilger.int>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 02:25:03PM -0700, Andreas Dilger wrote:
> On Oct 31, 2005  01:13 +0100, Adrian Bunk wrote:
> > Can anyone tell me the history of CONFIG_EXT{2,3}_CHECK?
> > 
> > There is code for a "check" option for mount if these options are 
> > enabled, but there's no way to enable them.
> 
> These are expensive debugging options, which walk the inode/block bitmaps
> for getting the group inode/block usage instead of using the group
> summary data.  Not used very often but I suspect occasionally useful for
> developers mucking with ext[23] internals.  Since it is developer-only
> code it needs to be enabled with #define CONFIG_EXT[23]_CHECK in a
> header or compile option.

It's basically a stripped down version of e2fsck pass #5, though.  Is
there any reason why this needs to be in the kernel?  If it would be
useful I could easily make a userspace implementation of these checks.

						- Ted
