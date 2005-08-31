Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbVHaUWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVHaUWe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 16:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbVHaUWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 16:22:34 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:11962 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964935AbVHaUWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 16:22:33 -0400
Message-ID: <43161126.3020700@us.ibm.com>
Date: Wed, 31 Aug 2005 13:20:54 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: State of Linux graphics
References: <9e47339105083009037c24f6de@mail.gmail.com>	<1125422813.20488.43.camel@localhost>	<20050831063355.GE27940@tuolumne.arden.org>	<1125512970.4798.180.camel@evo.keithp.com> <20050831200641.GH27940@tuolumne.arden.org>
In-Reply-To: <20050831200641.GH27940@tuolumne.arden.org>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=AC84030F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Allen Akin wrote:

> I believe we're doing well with layered implementation strategies like
> Xgl and Glitz.  Where we might do better is in (1) extending OpenGL to
> provide missing functionality, rather than creating peer low-level APIs;
> (2) expressing the output of higher-level services in terms of OpenGL
> entities (vertex buffer objects, framebuffer objects including textures,
> shader programs, etc.) so that apps can mix-and-match them and
> scene-graph libraries can optimize their use; (3) finishing decent
> OpenGL drivers for small and old hardware to address people's concerns
> about running modern apps on those systems.

I think that you and I are in total agreement.  I think #1 is the first
big barrier.  The problem is that I haven't seen a concrete list of the
deficiencies in OpenGL.  Before we can even consider how to extend the
API, we need to know where it needs to be extended.

I'd really like to see a list of areas where OpenGL isn't up to snuff
for 2D operations.  Ideally, items on this list would be put in one (or
more) of four categories:  missing (support for the required operation
is flat out missing from OpenGL), cumbersome (OpenGL can do it, but it
requires API acrobatics), ill defined (OpenGL can do it, but the spec
gives implementation enough leeway to make it useless for us), or slow
(OpenGL can do it, but the API overhead kills performance).

Having such a list would give us direction for both #1 and #3 in Alan's
list.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFDFhEmX1gOwKyEAw8RAiypAJwL/3RpnF10NwGX/hMyumPtMwAbcQCeIXWN
QUzBkYEbSXOKrI0MXIO84Pg=
=tPYg
-----END PGP SIGNATURE-----
