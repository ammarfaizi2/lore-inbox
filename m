Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267980AbUBRTsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 14:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267981AbUBRTsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 14:48:11 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:35456 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S267980AbUBRTsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 14:48:08 -0500
Date: Wed, 18 Feb 2004 20:47:44 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Message-ID: <20040218194744.GB1537@louise.pinerecords.com>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202142.GA5834@outpost.ds9a.nl> <c0ukd2$3uk$1@terminus.zytor.com> <Pine.LNX.4.58.0402171910550.2686@home.osdl.org> <4032DA76.8070505@zytor.com> <Pine.LNX.4.58.0402171927520.2686@home.osdl.org> <4032F861.3080304@zytor.com> <Pine.LNX.4.58.0402180716180.2686@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402180716180.2686@home.osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb-18 2004, Wed, 07:35 -0800
Linus Torvalds <torvalds@osdl.org> wrote:

> But it makes perfect sense to use a policy of:
>  - escape valid UTF-8 characters as '\u7777'
>  - escape _invalid_ UTF-8 characters as their hex byte sequence (ie 
>    '\xC0\x80\x80', whatever)
>  - (and, obviously, escape the valid UTF-8 character '\' as '\\').
> 
> Don't you agree? It clearly allows all the cases, and you can re-generate 
> the _exact_ original stream of bytes from the above (ie it is nicely 
> reversible, which in my opinion is a requirement).

I really really hope this is _exactly_ what we're going to see in practice.

-- 
Tomas Szepe <szepe@pinerecords.com>
