Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268339AbTGLTTd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 15:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268364AbTGLTTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 15:19:33 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:3988 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S268339AbTGLTTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 15:19:32 -0400
Date: Sat, 12 Jul 2003 20:34:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 'what to expect'
Message-ID: <20030712193401.GD10450@mail.jlokier.co.uk>
References: <20030711140219.GB16433@suse.de> <20030712152406.GA9521@mail.jlokier.co.uk> <3F103018.6020008@pobox.com> <20030712112722.55f80b60.akpm@osdl.org> <20030712183929.GA10450@mail.jlokier.co.uk> <3F105B9A.7070803@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F105B9A.7070803@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> These are separate db4+kernel problems.
> 
> The first is that there needs to be a reliable way to know if O_DIRECT 
> writes are going to succeed or not.  The 2.4 kernel fails on write(2) 
> but not open(2) or fcntl(2).
> 
> The second is that db4 doesn't appear to know about the alignment 
> requirement.

The alignment requirement can be probed if necessary - by reading a
misaligned page.  It's ugly, but fixable in db4.

2.4 fails on write()?  A strace of "rpm --rebuilddb" shows it is
opening with O_DIRECT and writing just fine.  Or does that only work
with RedHat's 2.4 kernels?

-- Jamie
