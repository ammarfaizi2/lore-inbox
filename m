Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUBMKI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 05:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266881AbUBMKI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 05:08:29 -0500
Received: from [212.28.208.94] ([212.28.208.94]:53254 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266880AbUBMKIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 05:08:02 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Fri, 13 Feb 2004 11:07:59 +0100
User-Agent: KMail/1.6.1
Cc: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       linux-kernel@vger.kernel.org
References: <1076604650.31270.20.camel@ulysse.olympe.o2t> <20040213030346.GF25499@mail.shareable.org>
In-Reply-To: <20040213030346.GF25499@mail.shareable.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402131107.59522.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 04.03, Jamie Lokier wrote:
> Nicolas Mailhot wrote:
> > But that's not a reason not to fix the core problem - I don't want to
> > spent hours fixing filenames next time someone comes up with a new
> > encoding. Please put valid encoding info somewhere or declare filenames
> > are utf-8 od utf-16 only - changing user locale should not corrupt old
> > data.
> 
> If you attach encoding to names for a whole filesystem, you will get
> really unpleasant bugs including security holes because some names
> won't be writable, so the fs will either return error codes when those
> names are used, or silently alter the names.

Depends on how to handle those undecodeble file names. non-ascii filenames are
probably a security issue (negative characters) with some apps. Making them inaccessible
is definitely not ok. I proposed one version, although it might be a good idea to look at those file
systems that handle the problem already so a uniform solution could be used that makes all filenames
accessible regardless of which characters are used and doesn't cause unneccessary
confusion as to what is the name.

-- robin
