Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279594AbRJXU7z>; Wed, 24 Oct 2001 16:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279596AbRJXU7i>; Wed, 24 Oct 2001 16:59:38 -0400
Received: from sigint.cs.purdue.edu ([128.10.2.82]:2177 "HELO
	sigint.cs.purdue.edu") by vger.kernel.org with SMTP
	id <S279594AbRJXU7d>; Wed, 24 Oct 2001 16:59:33 -0400
Date: Wed, 24 Oct 2001 16:00:02 -0500
From: linux@sigint.cs.purdue.edu
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] autofs4 symlink size
Message-ID: <20011024160002.A190@sigint.cs.purdue.edu>
In-Reply-To: <20011024102050.A12112@sigint.cs.purdue.edu> <9r781a$q9n$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9r781a$q9n$1@cesium.transmeta.com>; from hpa@zytor.com on Wed, Oct 24, 2001 at 01:24:10PM -0700
X-Disclaimer: Any similarity to an opinion of Purdue is purely coincidental
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2001 at 01:24:10PM -0700, H. Peter Anvin wrote:
> >
> > I sent this to the autofs4 maintainer a while ago, but never heard back.
> > autofs4 doesn't return a size for the symlinks it creates, which is
> > inconsistent with other filesystems.  (The Almquist shell uses the sizes
> > of path components to allocate buffers during a walk, so it can't traverse
> > autofs4-linked paths.)
> 
> That's IMNSHO a bug in the Almquist shell, at least if autofs4 returns
> zero, but it's also a bug in autofs4.

True, ash could do things differently, but I don't think expecting the
filesystem to return correct metadata is a bug.  Should we distrust stat(2)
and count the bytes in a file ourselves, just to be sure?
