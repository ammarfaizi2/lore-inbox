Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263119AbSJGPis>; Mon, 7 Oct 2002 11:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263122AbSJGPis>; Mon, 7 Oct 2002 11:38:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26899 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263119AbSJGPiQ>; Mon, 7 Oct 2002 11:38:16 -0400
Date: Mon, 7 Oct 2002 08:45:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bcopy()
In-Reply-To: <12660.1033999032@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44.0210070843330.2401-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Oct 2002, David Howells wrote:
>
> I've dicussed it with a number of people, and the general consensus seems to
> be that it should be nuked entirely? Do you agree?

I agree. bcopy should just DIE. Some architectures may have historical
trouble with gcc emitting bcopy for structure assignments (and that's
definitely a memcpy with no overlap), but I think that's long gone (I know 
gcc on alpha used to do this several years ago).

XFS seems to be a big user of bcopy, though..

		Linus

