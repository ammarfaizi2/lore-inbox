Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSKGP5n>; Thu, 7 Nov 2002 10:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261347AbSKGP5m>; Thu, 7 Nov 2002 10:57:42 -0500
Received: from crack.them.org ([65.125.64.184]:21254 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S261346AbSKGP5m>;
	Thu, 7 Nov 2002 10:57:42 -0500
Date: Thu, 7 Nov 2002 11:05:21 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Why are exe, cwd, and root priviledged bits of information?
Message-ID: <20021107160521.GA18270@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33L2.0211071052540.8252-100000@rtlab.med.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0211071052540.8252-100000@rtlab.med.cornell.edu>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 10:57:06AM -0500, Calin A. Culianu wrote:
> 
> In the /prod/PID subset of procfs, why are the exe, cwd, and root symlinks
> considered priviledged information?
> 
> Exe is the big one for me, as this one can be usually infered from reading
> /prod/PID/maps.  Root I guess can't be inferred in any unpriviledged way,
> and neither can cwd.  At any rate.. I am not sure behind the philosophy to
> make these symlinks' destinations priviledged...  can someone clarify
> this?

This came up a little while ago.  The answer is that maps should be
priviledged also.

For instance:
  You can protect a directory by giving its parent directory no read
permissions.  The name of the directory is now secret.  You don't want
to reveal it in cwd.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
