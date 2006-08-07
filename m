Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWHGIRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWHGIRw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 04:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWHGIRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 04:17:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:52383 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751158AbWHGIRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 04:17:51 -0400
X-Authenticated: #271361
Date: Mon, 7 Aug 2006 10:17:45 +0200
From: Edgar Toernig <froese@gmx.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       alan@lxorguk.ukuu.org.uk, tytso@mit.edu, tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Message-Id: <20060807101745.61f21826.froese@gmx.de>
In-Reply-To: <20060805122936.GC5417@ucw.cz>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	<20060805122936.GC5417@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>
> > This patch implements the revoke(2) and frevoke(2) system calls for
> > all types of files. The operation is done in passes: first we replace
> 
> 
> Do we need revoke()? open()+frevoke() should be fast enough, no?

Why do we need [f]revoke at all?  As it doesn't implement the
BSD semantic I can't see why it's better than fuser -k.

Ciao, ET.
