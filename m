Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264800AbUEQAvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264800AbUEQAvf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 20:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264817AbUEQAve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 20:51:34 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:4992 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264800AbUEQAv1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 20:51:27 -0400
Subject: Re: Strange NFS behavior (?)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kenneth =?ISO-8859-1?Q?Aafl=F8y?= <keaafloy@online.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200405170243.18245.keaafloy@online.no>
References: <200405170243.18245.keaafloy@online.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1084755081.3770.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 16 May 2004 20:51:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 16/05/2004 klokka 20:43, skreiv Kenneth Aafløy:

> Why does not the NFS code (server or client) try to either limit or increase 
> the buffer size when performance is at least 10x slower than that of the 
> medium it's mounted on, and no other load is present?

Which buffers? We already do automatic congestion control in the RPC
layer (and in the socket layer)...

> And why is the 
> performance really so bad with higher r/wsize?

Read the fine FAQ & HOWTO... The keywords are "UDP" and "fragmentation".
   http://nfs.sourceforge.net

Then go, use the "tcp" mount option and be happy...

Cheers,
  Trond
