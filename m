Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264768AbTF0UUd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 16:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264769AbTF0UUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 16:20:33 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:33804 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S264768AbTF0UUc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 16:20:32 -0400
Date: Fri, 27 Jun 2003 22:22:10 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: [ALPHA][2.5.7x] Problems with execve assembly rewriting
Message-ID: <20030627202210.GA29680@alpha.home.local>
References: <wrp4r2cpqye.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrp4r2cpqye.fsf@hina.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Thu, Jun 26, 2003 at 09:40:57PM +0200, Marc Zyngier wrote:
> Unable to handle kernel paging request at virtual address 5345432039323a38

This address is really messy since it's purely ASCII : "SEC 92:8"

> t0 = 00000000616d2820  t1 = 0000000033372e35
ASCII here : "am( " and here "37.5"

> t2 = 000000006920676e  t3 = 5345432039323a34
and here : "i gn" and here too "SEC 92:4"

So it may result from some garbage being used as a pointer, or a char * being
jumped to.

Just my .02 euros,
Willy

