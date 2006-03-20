Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWCTNX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWCTNX5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWCTNX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:23:57 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:41652 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932297AbWCTNX4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:23:56 -0500
Date: Mon, 20 Mar 2006 15:23:54 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Oliver Neukum <oliver@neukum.org>
cc: Denis Vlasenko <vda@ilport.com.ua>, Arjan van de Ven <arjan@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, viro@zeniv.linux.org.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]use kzalloc in vfs where appropriate
In-Reply-To: <200603201414.19998.oliver@neukum.org>
Message-ID: <Pine.LNX.4.58.0603201521020.19782@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0603172153160.30725@fachschaft.cup.uni-muenchen.de>
 <84144f020603192325h54fd3212l1f4846fd40b9f074@mail.gmail.com>
 <200603201508.47960.vda@ilport.com.ua> <200603201414.19998.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006, Oliver Neukum wrote:
> Why? size == 0 is a bug. We want to oops here.

Why do you want to oops? The standard calloc() deals with zero so 
kcalloc() should probably do that as well. In any case, if you want to 
change the behavior, please audit kcalloc() callers before optimizing.

			Pekka
