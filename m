Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275673AbTHODji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 23:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275674AbTHODji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 23:39:38 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:13837 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S275673AbTHODje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 23:39:34 -0400
Date: Fri, 15 Aug 2003 13:39:03 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Matt Mackall <mpm@selenic.com>
cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cryptoapi: Fix sleeping
In-Reply-To: <20030814201847.GO325@waste.org>
Message-ID: <Mutt.LNX.4.44.0308151337390.26882-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003, Matt Mackall wrote:

> Leaves no room actually. I figured this would be easy to move around
> after the fact.

Ok.

> On the subject of flags, what's the best way for an algorithm init
> function to get at the tfm structures (and thereby the flags) given a
> ctxt? Pointer math on a ctxt?

The algorithms should not access the tfm structure.  In the case of 
ciphers, we pass the tfm flags in via setkey.

What do you need this for?


- James
-- 
James Morris
<jmorris@intercode.com.au>

