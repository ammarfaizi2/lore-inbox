Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTIVDlu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 23:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbTIVDlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 23:41:50 -0400
Received: from nevyn.them.org ([66.93.172.17]:18633 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262765AbTIVDlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 23:41:49 -0400
Date: Sun, 21 Sep 2003 23:41:46 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CLONE_SIGHAND w/o CLONE_VM
Message-ID: <20030922034146.GA8083@nevyn.them.org>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1064199244.746.401.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064199244.746.401.camel@cube>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 10:54:05PM -0400, Albert Cahalan wrote:
> Does CLONE_SIGHAND without CLONE_VM ever
> make sense?
> 
> Note that the arch-specific kernel_thread()
> implementations add CLONE_VM, so kernel_thread()
> usage doesn't count unless you can point to an
> arch that doesn't add the CLONE_VM flag. (BTW, the
> user-mode port is missing CLONE_UNTRACED. Bug?)

Minor bug, but yes, it's a bug.  kernel threads should always be
CLONE_UNTRACED; UML wasn't in the tree when I added it.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
