Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbUJ1Pwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbUJ1Pwp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbUJ1PoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:44:13 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:49375 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261742AbUJ1Plg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:41:36 -0400
Date: Thu, 28 Oct 2004 17:41:32 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: "Theodore Ts'o" <tytso@mit.edu>, Timo Sirainen <tss@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: readdir loses renamed files
Message-ID: <20041028154132.GA6202@merlin.emma.line.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Timo Sirainen <tss@iki.fi>, linux-kernel@vger.kernel.org
References: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi> <20041025123722.GA5107@thunk.org> <20041028093426.GB15050@merlin.emma.line.org> <20041028114413.GL1343@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028114413.GL1343@schnapps.adilger.int>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004, Andreas Dilger wrote:

> I read over in reiserfs-list that the reason for the crazy renaming is
> to store "attributes" as part of the filename.  Why not just store them
> as EAs as they were intended?  With the large inode patches (posted here
> a couple of times already) the cost of storing EAs is negligible.

The "attributes" stored are really mail flags such as "read", "replied
to", the size and so on. Not sure if it makes sense storing these as
extended attributes, or, the other way around, are EAs supposed to be
some "associated" generic file that can be attached to an existing file?

At any rate, the resulting software would no longer be able to call
its backing storage to be in "Maildir" format.

I know AmigaOS had a limited amount of space (some dozen characters) for
a generic file comment, but otherwise.

-- 
Matthias Andree
