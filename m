Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbTE3VZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 17:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264227AbTE3VZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 17:25:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21266 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264085AbTE3VZ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 17:25:26 -0400
Date: Fri, 30 May 2003 14:38:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Steven Cole <elenstev@mesatop.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
In-Reply-To: <20030530212013.GE3308@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0305301431390.2671-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h4ULc7B16953
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 May 2003, Jörn Engel wrote:
> 
> How about an all or nothing approach?  If you really want to get rid
> of K&R, change indentation as well, rip out some of the rather
> tasteless macros (ZEXPORT, ZEXPORTVA, ZEXTERN, FAR, ...) and so on.

I'd love to, but I suspect we lack the motivation to do so, and there 
aren't any obvious upsides. Yes, the code is ugly, but it's also fairly 
stable so people seldom need to look at it.

The motivation for doing the ANSI-fication is just that there is now a 
sanity checker tool that will complain loudly about bad typing, and since 
I wrote it and I hate old-style K&R sources, it doesn't parse them. 

> You do have a point with the sync size.  The diff between 1.1.3 and
> 1.1.4 is 90k, of which only some 5k are functional changes.  The rest
> extends the copyright times, adds/changes documentation, etc.

I wouldn't mind syncing more, but one reason _against_ syncing the zlib 
sources have been the ugliness of them. Is there any reason for the 
K&R'ness any more, or the strange allocators?

		Linus

