Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264760AbUEPSUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264760AbUEPSUC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 14:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264758AbUEPSUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 14:20:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:32683 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264760AbUEPSUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 14:20:00 -0400
Date: Sun, 16 May 2004 11:19:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Andreas Amann <amann@physik.tu-berlin.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6 breaks kmail (nfs related?)
In-Reply-To: <1084731015.3764.10.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.58.0405161115000.25502@ppc970.osdl.org>
References: <200405131411.52336.amann@physik.tu-berlin.de> 
 <Pine.LNX.4.58.0405152142400.25502@ppc970.osdl.org> 
 <1084730382.3764.7.camel@lade.trondhjem.org> <1084731015.3764.10.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 May 2004, Trond Myklebust wrote:
> 
> Oh... Another thing that would be useful: mount options please...

They were in the original email on the kernel mailing list:

	hservnlds:/home /net/hservnlds/home nfs rw,nosuid,nodev,v3,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=sservnlds 0 

The only thing there is that "intr". Maybe something has broken so that 
non-lethal signals also trigger errors? That could explain it (partial 
reads or writes when a timer goes off, or something). 

			Linus
