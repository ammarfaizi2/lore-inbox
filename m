Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312381AbSEPLTD>; Thu, 16 May 2002 07:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312411AbSEPLTC>; Thu, 16 May 2002 07:19:02 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:52663 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S312381AbSEPLTC>; Thu, 16 May 2002 07:19:02 -0400
Date: Thu, 16 May 2002 12:21:44 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix BUG macro
In-Reply-To: <E178GJX-0005J5-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.21.0205161154410.1036-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002, Rusty Russell wrote:

> Replaces filename with object name.  Sure, it's not as canonical, but
> it means that ccache works across different directories (at the
> moment, ccache gets almost no caceh hits when you compile in a
> different dir).

__STRINGIZE(KBUILD_BASENAME) sounds good, except in inline
function from header file; perhaps that's why you're adding
__FUNCTION__, which will waste a lot of space.  Suggest you
should test __INCLUDE_LEVEL__: use __STRINGIZE(KBUILD_BASENAME)
at __INCLUDE_LEVEL__ 0, __FUNCTION__ at included levels?

[ empty space in which I try to keep quiet about ud2 disassembly ]

Hugh

