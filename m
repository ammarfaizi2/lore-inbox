Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318960AbSH1Uzl>; Wed, 28 Aug 2002 16:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318961AbSH1Uzl>; Wed, 28 Aug 2002 16:55:41 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:5667 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S318960AbSH1Uzk>; Wed, 28 Aug 2002 16:55:40 -0400
Date: Wed, 28 Aug 2002 15:59:58 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: trond.myklebust@fys.uio.no
cc: linux-kernel@vger.kernel.org
Subject: Re: problems with changing UID/GID
Message-ID: <65140000.1030568398@baldur.austin.ibm.com>
In-Reply-To: <15725.5853.229315.140365@charged.uio.no>
References: <Pine.LNX.4.44.0208260855480.3234-100000@hawkeye.luckynet.adm>
 <shsvg5wqemp.fsf@charged.uio.no><20020827200110.GB8985@tapu.f00f.org>
 <200208280009.03090.trond.myklebust@fys.uio.no>
 <19220000.1030544663@baldur.austin.ibm.com>
 <15725.5853.229315.140365@charged.uio.no>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, August 28, 2002 08:30:53 PM +0200 Trond Myklebust
<trond.myklebust@fys.uio.no> wrote:

> The BSD approach is to split out the user credentials, since they are
> used all over the place in the filesystems, and often need to be
> cached. The uid, euid, ... are kept in a reference-counted 'process'
> credential of the form

I like that approach, if you really think it's a good idea to have a
separate structure for the subset needed for IO.  I'm not clear why it'd be
a bad idea to have one structure and the IO subsystem would only use the
parts it cares about, but you've clearly thought about it more than I have,
so I'll take your word for it.

I looked through your patches.  It looks like you're on the right track,
generally.  I am a little concerned about some of the current_get*/set*
functions.  I'm not entirely convinced there aren't race conditions in
them, but I need to think harder on it.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

