Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265417AbTFVBmW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 21:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbTFVBmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 21:42:22 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:25011 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S265417AbTFVBmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 21:42:21 -0400
Date: Sat, 21 Jun 2003 18:56:23 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: torvalds@transmeta.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() again, and trivial nfs_fhget
Message-ID: <20030621185623.C29657@google.com>
References: <20030617051408.A17974@google.com> <shs1xxsr1gx.fsf@charged.uio.no> <20030617165507.A19126@google.com> <16112.63615.561414.52943@charged.uio.no> <20030621184623.A29657@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030621184623.A29657@google.com>; from fcusack@fcusack.com on Sat, Jun 21, 2003 at 06:46:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21, 2003 at 06:46:23PM -0700, Frank Cusack wrote:
> It's to prevent RENAME of silly-renamed files.  Doing so in VFS is a
> one-liner, and I agree that the VFS should be as clean as possible,
> but let's face it, the VFS *must* have specific fs knowledge.  eg,

I hate to keep following up myself, but I forgot one point I had in
mind: other code in may_delete() is already fs-specific.

IS_APPEND
IS_IMMUTABLE
check_sticky

These things aren't generic, they require specific support from the fs.
/fc
