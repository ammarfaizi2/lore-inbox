Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268484AbUIFTkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268484AbUIFTkP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 15:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268490AbUIFTkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 15:40:15 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:39838 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S268484AbUIFTj6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 15:39:58 -0400
Date: Mon, 6 Sep 2004 21:39:56 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [RFC] remove "broken_suid" nfs mount option
Message-ID: <20040906193956.GB859@janus>
References: <20040905213702.GA29401@janus> <1094420629.8081.39.camel@lade.trondhjem.org> <20040905215558.GA29526@janus> <1094421823.8081.44.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094421823.8081.44.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been discussed first on the nfs mailing list. Summary:

> To: Trond Myklebust
> Cc: Linux NFS mailing list
> Subject: [NFS] broken_suid mount option
> Date: Sun, 5 Sep 2004 23:37:02 +0200
> 
> Is this thing useful anymore? Google came up with this patch submission
> and description from you:
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0010.1/1178.html

 "To summarize the feature:
  
    The old NFS had a feature whereby if a setuid process failed due to
  EACCES or EPERM, the RPC engine would drop the privileged credentials,
  and retry using the uid/gid (instead of fsuid/fsgid).
    Of course, this sort of thing may be a security problem, so in 2.4.x
  (and in 2.2.18pre) it has been disabled by default. Unfortunately some
  broken programs rely on this silliness instead of bothering to
  dropping privileges themselves (the setuid version of xterm trying to
  read ~/.Xauthority being one of the more prominent offenders); hence
  the decision to make a new mount option..."


On Sun, Sep 05, 2004 at 06:03:43PM -0400, Trond Myklebust wrote:
> 
> If people agree that we can remove it, then I'll take the patch. The
> whole point of making it a mount option (rather than the default as used
> to be the case earlier) was to allow us to deprecate it.
> 
> Note, though, that we should take this one too to lkml in order to get a
> proper concensus.
> 

-- 
Frank
