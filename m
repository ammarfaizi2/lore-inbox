Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUF3U2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUF3U2Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUF3U2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:28:25 -0400
Received: from gw.c9x.org ([213.41.131.17]:44828 "HELO
	nerim.mx.42-networks.com") by vger.kernel.org with SMTP
	id S262080AbUF3U2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:28:22 -0400
Date: Wed, 30 Jun 2004 22:27:58 +0159
From: Jedi/Sector One <lkml@pureftpd.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 4/4: DM: dm-raid1.c: Use fixed-size arrays
Message-ID: <20040630202820.GA13408@c9x.org>
References: <200406301452.16886.kevcorry@us.ibm.com> <200406301458.46109.kevcorry@us.ibm.com> <200406302207.56348.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406302207.56348.mbuesch@freenet.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 10:07:53PM +0200, Michael Buesch wrote:
> Quoting Kevin Corry <kevcorry@us.ibm.com>:
> > -	struct io_region from, to[ms->nr_mirrors - 1], *dest;
> 
> Heh? Could someone please explain how this could compile?

  Such a dynamic allocation on the stack is a GCC extension, implemented for
a very long time.

  I guess this is not very different from alloca().
  
