Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWHaTRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWHaTRD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 15:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWHaTRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 15:17:03 -0400
Received: from THUNK.ORG ([69.25.196.29]:34011 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932150AbWHaTRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 15:17:01 -0400
Date: Thu, 31 Aug 2006 15:16:49 -0400
From: Theodore Tso <tytso@mit.edu>
To: Richard Amick <richa03@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXT3-fs error
Message-ID: <20060831191649.GC5708@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Richard Amick <richa03@gmail.com>, linux-kernel@vger.kernel.org
References: <26279fb90608311102w2d74ed03w1ca5d1ea359a8b1b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26279fb90608311102w2d74ed03w1ca5d1ea359a8b1b@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 11:02:35AM -0700, Richard Amick wrote:
> 
> My question:
> How do I determine what is/was contained in "directory #14058742"?

You can run debugfs on the mounted filesystem and give the command:

debugfs: ls <14058742>

You can figure out its pathname by doing a:

debugfs: cd <14058742>
debugfs: pwd

> Running e2fsck is really not an option right now as this is a
> production server and a very large volume (300GB with 150GB used).

Note though that your filesystem *is* corrupted, and running with
errors (as you are currently doing) can risk further filesystem
corruption leading to data loss --- in the worst case, significant
data loss.  

In this particular case, if the reported corrupted directory entry is
the *only* filesystem corruption, it's not likely that it will cause
any problems, but....  This is the point where sky divers are asked to
sign a liability release waiver that essentially says, "I am about to
do this really silly, dangerous thing of my own free will, and it
could lead to significant injury or DEATH."  It might be safe to sky
dive --- although I've never seen the point of jumping out of a
perfectly good airplane --- but there is risk involved.  Some people
seem to get off on risk, though.  :-)

At the very least, I would recommend doing a full backup of your
system....

					- Ted
