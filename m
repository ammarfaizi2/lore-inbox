Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSGGSxQ>; Sun, 7 Jul 2002 14:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSGGSxP>; Sun, 7 Jul 2002 14:53:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17165 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316430AbSGGSxO>;
	Sun, 7 Jul 2002 14:53:14 -0400
Date: Sun, 7 Jul 2002 19:55:54 +0100
From: Matthew Wilcox <willy@debian.org>
To: kuznet@ms2.inr.ac.ru
Cc: Matthew Wilcox <willy@debian.ORG>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] simplify networking fcntl
Message-ID: <20020707195554.O27706@parcelfarce.linux.theplanet.co.uk>
References: <20020707171555.L27706@parcelfarce.linux.theplanet.co.uk> <200207071709.VAA17085@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207071709.VAA17085@sex.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Sun, Jul 07, 2002 at 09:09:02PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 09:09:02PM +0400, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > sock_no_fcntl is only called for F_SETOWN, so it can stand some
> > simplification.
> 
> sk->proc. Sorry, generic F_SETOWN does not handle SIGURG.

indeed -- did you read the patch?  i simplified sock_no_fcntl so it
_only_ handled F_SETOWN, which is the only time it's called.

-- 
Revolutions do not require corporate support.
