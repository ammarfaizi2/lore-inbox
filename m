Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWHGFm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWHGFm7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWHGFm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:42:59 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:35972 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751087AbWHGFm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:42:58 -0400
Date: Mon, 7 Aug 2006 08:42:57 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, alan@lxorguk.ukuu.org.uk, tytso@mit.edu,
       tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
In-Reply-To: <20060805122936.GC5417@ucw.cz>
Message-ID: <Pine.LNX.4.58.0608070840590.24153@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
 <20060805122936.GC5417@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in time, I wrote:
> > This patch implements the revoke(2) and frevoke(2) system calls for
> > all types of files. The operation is done in passes: first we replace

On Sat, 5 Aug 2006, Pavel Machek wrote:
> Do we need revoke()? open()+frevoke() should be fast enough, no?

Not a speed issue, open can have side effects which we might want to 
avoid. See comments from Alan and Ulrich in this thread.

				Pekka
