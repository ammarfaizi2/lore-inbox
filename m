Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314643AbSESQ6n>; Sun, 19 May 2002 12:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314670AbSESQ6m>; Sun, 19 May 2002 12:58:42 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:2873 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S314643AbSESQ6m>; Sun, 19 May 2002 12:58:42 -0400
Date: Sun, 19 May 2002 18:01:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rui Sousa <rui.sousa@laposte.net>, Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel@vger.kernel.org,
        kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: AUDIT of 2.5.15 copy_to/from_user
In-Reply-To: <E179Qxm-0003nQ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0205191755200.9972-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 May 2002, Alan Cox wrote:
> > 
> > On the emu10k1 driver we use access_ok(VERIFY_READ) once at the beginning
> > of the write() routine to check we can access the user buffer. After that 
> > we always use __copy_from_user() and we trust it not to fail. Is this 
> > correct, or not?
> 
> This is correct

Am I right to read that as "This is a correct description of what is
currently done in the emu10k1 driver, but what it is doing is incorrect"?

> Static once off checks are done in access_ok
> Dynamic checks are doing in __copy_from_*
> 
> Which are which depends on the platform. On x86 for example access_ok
> is basically a check for 0->0xBFFFFFFF range and no more

Hugh

