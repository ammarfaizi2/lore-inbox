Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266121AbUAQUj7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 15:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUAQUj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 15:39:58 -0500
Received: from mail.willden.org ([63.226.98.113]:47493 "EHLO zedd.willden.org")
	by vger.kernel.org with ESMTP id S266121AbUAQUjz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 15:39:55 -0500
From: Shawn Willden <shawn-lkml@willden.org>
To: Mark Borgerding <mark@borgerding.net>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
Date: Sat, 17 Jan 2004 13:39:36 -0700
User-Agent: KMail/1.5.93
References: <Xine.LNX.4.44.0401161039480.20623-100000@thoron.boston.redhat.com> <40081AF0.5060907@borgerding.net>
In-Reply-To: <40081AF0.5060907@borgerding.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200401171339.43800.shawn-lkml@willden.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 16 January 2004 10:10 am, Mark Borgerding wrote:
> Thinking of it another way, this is equivalent to CBC mode having two 
> IVs: the first one being the sector number, the second a block of
> zeros. 

Even simpler, conceptually, it's equivalent to prepending a block of zeros 
to every sector prior to encrypting.

I'm not one to argue with Eli Biham (even second or third-hand), but it's 
really hard to see how this makes any difference at all.

	Shawn.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFACZ2Op1Ep1JptinARAkzhAJ46cOO7JS0ccoid7aer7p+nZ1K2DQCbB3In
JeIsagKKEsBaRiEZY+sElZ8=
=ISsB
-----END PGP SIGNATURE-----
