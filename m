Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318410AbSGRW02>; Thu, 18 Jul 2002 18:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318413AbSGRW02>; Thu, 18 Jul 2002 18:26:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31997 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318410AbSGRWYt>; Thu, 18 Jul 2002 18:24:49 -0400
Subject: Re: [PATCH] strict VM overcommit
From: Robert Love <rml@tech9.net>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <Pine.NEB.4.44.0207182359300.17300-100000@mimas.fachschaften.tu-muenchen.de>
References: <Pine.NEB.4.44.0207182359300.17300-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Jul 2002 15:27:26 -0700
Message-Id: <1027031246.1086.158.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 15:08, Adrian Bunk wrote:

> Out of interest:
> 
> How is assured that it's impossible to OOM when the amount of memory
> shrinks?
> 
> IOW:
> - allocate very much memory
> - "swapoff -a"

Well, seriously: don't do that.

But `swapoff' will not succeed if there is not enough swap or physical
memory to move the pages to... if it does succeed, then there is enough
storage elsewhere.  At that point, you are not OOM but you may now have
more address space allocated than the strict accounting would typically
allow - thus no allocations will succeed so you should not be able to
OOM.

	Robert Love

