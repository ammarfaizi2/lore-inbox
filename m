Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135423AbRAQUku>; Wed, 17 Jan 2001 15:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132815AbRAQUjv>; Wed, 17 Jan 2001 15:39:51 -0500
Received: from [64.64.109.142] ([64.64.109.142]:36363 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S130643AbRAQUjg>; Wed, 17 Jan 2001 15:39:36 -0500
Message-ID: <3A6601BB.801EFBFF@didntduck.org>
Date: Wed, 17 Jan 2001 15:34:03 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Shawn Starr <Shawn.Starr@Home.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION]: Applying patches ontop of patches (2.4.1pre7 to 
 2.4.1pre8)
In-Reply-To: <3A65F3DA.7E2C8823@Home.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> 
> What is the best way to apply a patch on top of a patch already applied?
> 
> For example, with original sources 2.4.0 i applied 2.4.1pre7 but now
> that pre8 is out, how do i apply those new patches without having to
> delete the whole linux dir and untar 2.4.0 again just to apply pre8?

You can unapply -pre7 (patch -R) or make a hard-linked tree to apply the
pre patches to.  Patch will break the hard links on the files it
modifies, so the second tree hardly takes up any disk space.  To make
the second tree do:

cp -al linux-2.4.0 linux-2.4.1-pre8

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
