Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbUEQSB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUEQSB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 14:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUEQSB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 14:01:26 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:63876 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S262050AbUEQSBW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 14:01:22 -0400
Subject: Re: 2.6.6 breaks kmail (nfs related?)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: norberto+linux-kernel@bensa.ath.cx, linux-kernel@vger.kernel.org
In-Reply-To: <20040517103502.6b84db26.akpm@osdl.org>
References: <200405131411.52336.amann@physik.tu-berlin.de>
	 <200405170335.42754.norberto+linux-kernel@bensa.ath.cx>
	 <20040517001431.7b4d8cda.akpm@osdl.org>
	 <20040517103502.6b84db26.akpm@osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1084816879.3669.135.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 17 May 2004 14:01:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 17/05/2004 klokka 13:35, skreiv Andrew Morton:

> Norberto's strace log is at
> http://www.zip.com.au/~akpm/linux/patches/stuff/log.txt

A priori, it looks very different from Andreas' problem. This beast is
crashing due to a SIGSEGV.

The EBADF here appear to be correct: the application or glibc or
whatever appears to be trying to close files more than once. Duh...

Cheers,
  Trond
