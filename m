Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316738AbSERBVf>; Fri, 17 May 2002 21:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316739AbSERBVe>; Fri, 17 May 2002 21:21:34 -0400
Received: from dsl-213-023-043-065.arcor-ip.net ([213.23.43.65]:43911 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316738AbSERBVd>;
	Fri, 17 May 2002 21:21:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: Htree directory index for Ext2, updated
Date: Sat, 18 May 2002 03:21:15 +0200
X-Mailer: KMail [version 1.3.2]
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <200205170736.g4H7aNj281162@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E178suL-0000Bs-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 May 2002 09:36, Albert D. Cahalan wrote:
> ----------- the insanity -------------
> 
> Ignoring RCS/ClearCase/SCCS, the algorithm is
> claimed to be:
> 
> patch takes an ordered list of candidate file names
> ...
> old, new, index   [index is from "Index:" line]
> ...
> If some of the named files exist, patch selects
> the first name if conforming to POSIX,

This is amazingly stupid.  The naive user would always expect the
file prefixed with '+++' to be selected, whether or not it exists.

> and the "best" [*] name otherwise.

Which is about the only way to make the selection process even
less sensible.

> [...]
> Half of the badness is POSIX mandated. As for
> the other half... well, you should produce
> patches that work with the existing tools.

Patch is severely broken in its current form, not only for the
reasons you stated, but also because of its inability to handle
renaming in any sane way.  I want a patch --sane option.

-- 
Daniel
