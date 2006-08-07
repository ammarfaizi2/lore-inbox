Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWHGW4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWHGW4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWHGW4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:56:47 -0400
Received: from nevyn.them.org ([66.93.172.17]:55255 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1750952AbWHGW4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:56:43 -0400
Date: Mon, 7 Aug 2006 18:56:42 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Message-ID: <20060807225642.GA31752@nevyn.them.org>
Mail-Followup-To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI> <20060807101745.61f21826.froese@gmx.de> <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com> <20060807224144.3bb64ac4.froese@gmx.de> <eb8g8b$837$1@taverner.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb8g8b$837$1@taverner.cs.berkeley.edu>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 10:52:59PM +0000, David Wagner wrote:
> I'm still trying to understand the semantics of this proposed
> frevoke() implementation.  Can an attacker use this to forcibly
> close some other processes' file descriptor?  Suppose the target
> process has fd 0 open and the attacker revokes the file corresponding
> to fd 0; what is the state of fd 0 in the target process?  Is it
> closed?  If the target process then open()s another file, does it
> get bound to fd 0?  (Recall that open() always binds to the lowest
> unused fd.)  If the answers are "yes", then the security consequences
> seem very scary.

No, that's already been answered at least once.  The file remains open,
but returns EBADF on various operations.

-- 
Daniel Jacobowitz
CodeSourcery
