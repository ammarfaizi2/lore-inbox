Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262784AbTDATL5>; Tue, 1 Apr 2003 14:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262785AbTDATL5>; Tue, 1 Apr 2003 14:11:57 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:36877 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S262784AbTDATLz>; Tue, 1 Apr 2003 14:11:55 -0500
Date: Tue, 1 Apr 2003 20:25:16 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Daniel Egger <degger@fhm.edu>
cc: Christoph Rohland <cr@sap.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
In-Reply-To: <1049221575.7628.14.camel@localhost>
Message-ID: <Pine.LNX.4.44.0304012020290.1253-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Apr 2003, Daniel Egger wrote:
> Am Die, 2003-04-01 um 18.24 schrieb Christoph Rohland:
> 
> > But on these systems you better use ramfs.
> 
> Just curious: Why? I'm using tmpfs on these systems and I'm rather
> satisfied with it; especially the option to limit the amount of space
> makes it rather useful. According to the documentation ramfs is most
> useful as an educational example how to write filesystems not as a 
> real filesystem...

Simply because quite a lot of the tmpfs code is concerned with moving
pages between ram and swap: if you've limited ram and no swap, you may
not want to waste your ram on that code!  One day I might try applying
#ifdef CONFIG_SWAPs within mm/shmem.c; but I might well not, it could
get ugly, and looks rudimentary elsewhere - do we intend to get serious
about CONFIG_SWAP?

Hugh

