Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264369AbTKZXif (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 18:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264387AbTKZXie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 18:38:34 -0500
Received: from ns.suse.de ([195.135.220.2]:65251 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264369AbTKZXic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 18:38:32 -0500
Date: Thu, 27 Nov 2003 00:38:30 +0100
From: Andi Kleen <ak@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andi Kleen <ak@suse.de>, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-ID: <20031126233830.GB5274@wotan.suse.de>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel> <20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel> <p73fzgbzca6.fsf@verdi.suse.de> <shsllq3yy2u.fsf@charged.uio.no> <20031127000145.61187530.ak@suse.de> <16325.13797.417933.122067@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16325.13797.417933.122067@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There are a still few inefficiencies with this approach, though. Most
> notable is the fact that you need to call kmap_atomic() several times
> per page since the socket lower layers will usually be feeding you 1
> skb at a time. I thought you might be referring to those (and that you
> might have a good solution to propose ;-))

For kmap_atomic? Run a x86-64 box ;-) 

In general doing things with more than one packet at a time would
be probably a good idea, but I don't have any deep thoughts on how
to implement this for TCP RX.

-Andi
