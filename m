Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTFPMm7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 08:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTFPMm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 08:42:59 -0400
Received: from madrid10.amenworld.com ([217.174.194.138]:37382 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S262934AbTFPMm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 08:42:58 -0400
Date: Mon, 16 Jun 2003 14:58:07 +0200
From: DervishD <raul@pleyades.net>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND][PATCH] against mmap.c (do_mmap_pgoff) and a note
Message-ID: <20030616125807.GC57@DervishD>
References: <20030421110427.GA127@DervishD> <20030615102039.GA1063@wohnheim.fh-wedel.de> <20030616094911.GB43@DervishD> <20030616113351.GB18717@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030616113351.GB18717@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jörn :)

 * Jörn Engel <joern@wohnheim.fh-wedel.de> dixit:
> >     There is a change in archs where TASK_SIZE is the entire
> > addressable space (like sparc64). Ask Dave S., again. The problem did
> > arise when TASK_SIZE is ~0. Then semantics change.
> True.  PAGE_ALIGN(-1) = 0 and that case would not get caught with the
> old code.  Looks good to me.

    This was pointed to me by Dave. I prepared a patch time ago just
for the case where 'len' was quite large, but I assumed that
TASK_SIZE was at least one less page than the entire addressable
space, which is not true. My fault O:))

    Thanks for pointing, anyway.

> Public Domain  - Free as in Beer
> General Public - Free as in Speech
> BSD License    - Free as in Enterprise
> Shared Source  - Free as in "Work will make you..."

    Good one ;))))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
