Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbSKMRDm>; Wed, 13 Nov 2002 12:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbSKMRDm>; Wed, 13 Nov 2002 12:03:42 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:14250 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262289AbSKMRDl>; Wed, 13 Nov 2002 12:03:41 -0500
Subject: Re: [STATUS 2.5]  November 13, 2002
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021113161150.GA10118@suse.de>
References: <3DD22BBE.14582.4A4D5ABA@localhost> 
	<20021113161150.GA10118@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 17:36:04 +0000
Message-Id: <1037208964.11979.106.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-13 at 16:11, Dave Jones wrote:
> On Wed, Nov 13, 2002 at 10:38:54AM -0500, Guillaume Boissiere wrote:
>  > Things are stabilizing after the feature freeze.  Of note the 
>  > merge of a new kernel module loader.
> 
> Something of a contradiction.. 8-)
>  
>  > o in 2.5.35  Serial ATA support  (Andre Hedrick)  
> 
> AFAIK, this still isn't merged.

Basic SII SATA support is merged. There are more infrastructure related
matters to resolve next - SATA hot swap means drivers can change
underneath users and neither the users nor the locking in the IDE code
expects it. "Suprise its a tape now!" during a CD burn for example

Beyond that there is the matter of SATA addressing, SATA2 and all the
mmio handling which right now is -really-ugly- because the core code
doesn't know what its doing.

You can use SATA in 2.5.47, just don't do anything clever with it 

