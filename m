Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbTFDVHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264086AbTFDVHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:07:21 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:56612 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264085AbTFDVHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:07:19 -0400
Date: Wed, 4 Jun 2003 14:20:47 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs_refresh_inode: inode number mismatch
Message-ID: <20030604142047.C24603@google.com>
References: <20030603165438.A24791@google.com> <shswug2sz5x.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <shswug2sz5x.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Jun 04, 2003 at 04:19:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 04:19:38PM +0200, Trond Myklebust wrote:
> >>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:
>      > At this point, fs/nfs/inode.c:__nfs_refresh_inode() prints the
>      > "inode number mismatch" error.  AFAICT, this is just noise, but
>      > the noise is driving me crazy. :-)
> 
> Inode number mismatch points to either an an obvious server error (it
> is not providing unique filehandles) or corruption of the fattr struct
> that was passed to nfs_refresh_inode().

Clearly it's not the former.  No way a netapp filer is going to have
this problem.  I can't imagine *any* nfs server having this problem.

Could you take another look at the specific case I cited?  At the time
I try to access the file, the path to it no longer exists.  No information
on this file should exist.

/fc
