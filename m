Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272329AbTHOXgA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 19:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272337AbTHOXgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 19:36:00 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:22029 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S272329AbTHOXf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 19:35:59 -0400
Date: Sat, 16 Aug 2003 09:35:24 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Matt Mackall <mpm@selenic.com>, Jamie Lokier <jamie@shareable.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, <davem@redhat.com>
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
In-Reply-To: <20030815221211.GA4306@think>
Message-ID: <Mutt.LNX.4.44.0308160927070.30515-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003, Theodore Ts'o wrote:

> > d) not disable preemption for long stretches while hashing (a
> >    limitation of cryptoapi)
> 
> Sounds like a bug in CryptoAPI that should be fixed in CryptoAPI.

This is for the case of hashing from a per cpu context, which is an
inherently unsafe context for introducing schedule points.  This is not
a crypto API specific problem.


- James
-- 
James Morris
<jmorris@intercode.com.au>

