Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbSKRMpv>; Mon, 18 Nov 2002 07:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262387AbSKRMpv>; Mon, 18 Nov 2002 07:45:51 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:30643 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262384AbSKRMpu>; Mon, 18 Nov 2002 07:45:50 -0500
Subject: Re: [patch] threading fix, tid-2.5.47-A3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Luca Barbieri <ldb@ldb.ods.org>, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211181322281.1639-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0211181322281.1639-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Nov 2002 13:20:19 +0000
Message-Id: <1037625619.7547.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-18 at 12:26, Ingo Molnar wrote:
> 
> and we have VM_DONTCOPY already, which is used by the DRM code. So it
> would only be a question of exporting this API to userspace. The attached
> patch adds MAP_DONTCOPY. I made it unpriviledged, i doubt it has any
> security impact.

What is the behaviour of someone setting VM_DONTCOPY on memory that was
copy on write between a large number of processes (say an executable
image) ?  Don't copy - but don't copy from what, from the original
mapping or from the COW mapping of the original mapping ?

Alan

