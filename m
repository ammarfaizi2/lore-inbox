Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267331AbTACAFa>; Thu, 2 Jan 2003 19:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267333AbTACAF3>; Thu, 2 Jan 2003 19:05:29 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16266
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267331AbTACAF2>; Thu, 2 Jan 2003 19:05:28 -0500
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: lm@bitmover.com, tom@rhadamanthys.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030102.151600.129375771.davem@redhat.com>
References: <20030102221210.GA7704@window.dhis.org>
	<20030102222816.GF2461@work.bitmover.com>
	<1041549644.24829.66.camel@irongate.swansea.linux.org.uk> 
	<20030102.151600.129375771.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Jan 2003 00:56:59 +0000
Message-Id: <1041555419.24901.86.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-02 at 23:16, David S. Miller wrote:    
>    It depends how predictable your content is. With a 64bit box and a porn
>    server its probably quite tidy
>    
> Let's say you have infinite VM (which is what 64-bit almost is :) then
> the cost is setting up all of these useless VMAs for each and every
> file (which is a 1 time cost, ok), and also the VMA lookup each
> write() call.
> 
> With sendfile() all of this goes straight to the page cache directly
> without a VMA lookup.

With a nasty unpleasant splat the moment you do modification on the
content at all. For static objects sendfile is certainly superior,

