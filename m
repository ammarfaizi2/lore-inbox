Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSGUMb2>; Sun, 21 Jul 2002 08:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSGUMb2>; Sun, 21 Jul 2002 08:31:28 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:32501 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314149AbSGUMb2>; Sun, 21 Jul 2002 08:31:28 -0400
Subject: Re: [PATCH] VM strict overcommit, again
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, akpm@zip.com.au,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <1027216974.1116.996.camel@sinai>
References: <1027216974.1116.996.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 14:46:31 +0100
Message-Id: <1027259191.16818.94.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 03:02, Robert Love wrote:
> OK, here we go again...
> 
> Attached patch implements VM strict overcommit with the following
> changes over the previous patch:

Looks good to me

> 	- (unrelated to the controversy) back out some of the shmem
> 	  changes.  I am weary of them and they would be best brought
> 	  forward from 2.4-ac in pieces. 2.4-ac, btw, has quite
> 	  a few shmem fixes.

This is probably wise. Its partly complicated by the fact that the shmem
changes are in part very recent (Hugh fixed a load) and also by the fact
-ac has a vm callback for when a page cache page is freed up which is
used by the shmem code I have

