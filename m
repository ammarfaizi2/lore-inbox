Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWJFKgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWJFKgh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 06:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWJFKgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 06:36:37 -0400
Received: from aun.it.uu.se ([130.238.12.36]:47258 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751431AbWJFKgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 06:36:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17702.12704.868782.312125@alkaid.it.uu.se>
Date: Fri, 6 Oct 2006 12:36:16 +0200
From: Mikael Pettersson <mikpe@it.uu.se>
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Really good idea to allow mmap(0, FIXED)?
In-Reply-To: <1160119515.3000.89.camel@laptopd505.fenrus.org>
References: <200610052059.11714.mb@bu3sch.de>
	<eg4624$be$1@taverner.cs.berkeley.edu>
	<1160119515.3000.89.camel@laptopd505.fenrus.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven writes:
 > >     mmap(0, 4096, PROT_READ|PROT_EXEC|PROT_WRITE,
 > >         MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
 > >     struct s *bar = 0;
 > 
 > the question isn't if it's a good idea to allow mmap(0) but to allow
 > mmap PROT_WRITE | PROT_EXEC !

It is if you want JITs, code loaders, virtualisation engines, etc
to continue working.
