Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270606AbTGTChj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 22:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270607AbTGTChi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 22:37:38 -0400
Received: from thunk.org ([140.239.227.29]:59323 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S270606AbTGTChb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 22:37:31 -0400
Date: Sat, 19 Jul 2003 20:31:41 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dan Behman <dbehman@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: marking individual directories as synchronous?
Message-ID: <20030720003141.GB1085@think>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Dan Behman <dbehman@hotmail.com>, linux-kernel@vger.kernel.org
References: <Law14-F4339RtMXxIGC0001edbb@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law14-F4339RtMXxIGC0001edbb@hotmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 04:59:20PM -0400, Dan Behman wrote:
> Hi,
> 
> I'm reading through Joseph Pranevich's great document "Wonderful World of 
> Linux 2.6" and I came across something that I'd love to learn more about.  
> In the "Block Device Support" -> "Filesystems" section, reference is made 
> to "Individual directories can now be marked as synchronous so that all 
> changes (additional files, etc.) will be atomic".  I searched through the 
> update info at kernelnewbies but
> couldn't find any more information on this - could someone please elaborate 
> on this?  What is it and how does it work?  Is there any design 
> documentation for this?

He is is probably referring to "chattr +S".  See the man page for
chattr for more information.  Note that strictly speaking this does
not necessarily give you "atomic changes".  It does mean that changes
are scheduled to be immediately written to disk, but that does not
guarantee atomicity, at least not for all filesystems and for all
operations.  You *can* be guaranteed that system calls will not return
until the changes are on disk; note though that this does have has
some significant performance impacts.

						- Ted
