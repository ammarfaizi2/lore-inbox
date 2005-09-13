Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbVIMOIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVIMOIc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVIMOIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:08:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8969 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964784AbVIMOIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:08:30 -0400
Date: Tue, 13 Sep 2005 15:08:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Missing #include <config.h>
Message-ID: <20050913150825.A23643@flint.arm.linux.org.uk>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20050913135622.GA30675@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050913135622.GA30675@phoenix.infradead.org>; from joern@infradead.org on Tue, Sep 13, 2005 at 02:56:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 02:56:23PM +0100, Jörn Engel wrote:
> After spending some hours last night and this morning hunting a bug,
> I've found that a different include order made a difference.  Some
> files don't work correctly, unless config.h is included before.

I'm still of the opinion that we should add

	-imacros include/linux/config.h

to the gcc command line and stop bothering with trying to get
linux/config.h included into the right files and not in others.
(which then means we can eliminate linux/config.h from all files.)

>From what you can see below, missing includes of it can remain
for months, and it can cause bugs which are rather non-obvious.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
