Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269417AbUHZTNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269417AbUHZTNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269356AbUHZTNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:13:33 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:26277 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S269374AbUHZTLC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:11:02 -0400
Subject: Re: POSIX_FADV_NOREUSE and O_STREAMING behavior in 2.6.7
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Greaves <david@dgreaves.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <412E2E0D.8040401@dgreaves.com>
References: <412E2058.60302@rtlogic.com>  <412E2E0D.8040401@dgreaves.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1093547459.6106.57.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 15:11:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 26/08/2004 klokka 14:38, skreiv David Greaves:
> David Rolenc wrote:
> 
> > I am trying to get O_STREAMING (Robert Love patch for 2.4) behavior in 
> > 2.6 and just a glance at fadvise.c suggests that POSIX_FADV_NOREUSE is 
> > not implemented any differently than POSIX_FADV_WILLNEED. Am I missing 
> > something?  I want to read data from disk with readahead and drop the 
> > data from the page cache as soon as I am done with it. Do I have to 
> > call fadvise with POSIX_FADV_DONTNEED after every read?
> 
> And will this work over nfs?

What do you mean?

The client will of course respect fadvise() if the generic VM code
supports it, but there is no NFS protocol support for this, so the
client is not able to communicate your fadvise call on to the server.

Cheers,
  Trond
