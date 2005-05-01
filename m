Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVEAD5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVEAD5y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 23:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVEAD5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 23:57:54 -0400
Received: from thunk.org ([69.25.196.29]:467 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261520AbVEAD5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 23:57:52 -0400
Date: Sat, 30 Apr 2005 23:57:47 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Lang <dlang@digitalinsight.com>
Cc: Daniel Phillips <phillips@istop.com>, Lars Marowsky-Bree <lmb@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] dlm: overview
Message-ID: <20050501035746.GA6578@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	David Lang <dlang@digitalinsight.com>,
	Daniel Phillips <phillips@istop.com>,
	Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
References: <20050425151136.GA6826@redhat.com> <20050428145715.GA21645@marowsky-bree.de> <Pine.LNX.4.62.0504281731450.6139@qynat.qvtvafvgr.pbz> <200504282152.31137.phillips@istop.com> <Pine.LNX.4.62.0504291011220.7439@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504291011220.7439@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the claim was that UUID's are unique and don't have to be assigned by the 
> admins.
> 
> I'm saying that in my experiance there isn't any standard or reliable way 
> to generate such a UUID and I'm asking for the people makeing the 
> claim to educate me on what I'm missing becouse a reliable UUID for linux 
> on all hardware would be extremely useful for many things.

How to reliably generate universally unique ID's have been well
understood for over twenty years, and is implemented on nearly every
Linux system for over ten.  For more information I refer you to
doc/draft-leach-uuid-guids-01.txt in the e2fsprogs sources, and for an
implementation, the uuid library in e2fsprogs, which is used by both
GNOME and KDE.  UUID's are also used by Apple's Mac OS X (using
libuuid from e2fsprogs), Microsoft Windows, more historically by the
OSF DCE, and even more historically by the Apollo Domain OS (1980 --
1989, RIP).  Much of this usage is due to the efforts of Paul Leach, a
key architect at Apollo, and OSF/DCE, before he left and joined the
Dark Side at Microsoft.

Also, FYI the OSF/DCE, including the specification for generating
UUID's, was submitted by OSF to the X/Open where it was standardized,
who in turn submitted it to the ISO where it was approved as
Publically Available Specification (PAS).  So technically, there *is*
an internationally standardized way of generating UUID's, and it is
already implemented and deployed on nearly all Linux systems.

						- Ted
