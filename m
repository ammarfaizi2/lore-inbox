Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265466AbUAPNoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 08:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265465AbUAPNoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 08:44:11 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:49280
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S265466AbUAPNn6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 08:43:58 -0500
Subject: Re: Fwd: [2.6] nfs_rename: target $file busy, d_count=2
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Roman Kagan <Roman.Kagan@itep.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040116123232.GA22836@panda.itep.ru>
References: <20040116123232.GA22836@panda.itep.ru>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074260634.1996.109.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 16 Jan 2004 08:43:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 16/01/2004 klokka 07:32, skreiv Roman Kagan:

> I don't see your nfs_rename problem on the clients.  Nor do they get
> stale NFS handles: there used to be some until I added no_subtree_check
> export option.

Sure. subtree checking will break renames if you rename from one
directory to another. This is not a new 2.6 feature. It occurs on 2.4
servers too...
It is because a server with subtree checking enabled will encode the
parent directory inside the filehandle. When you rename so that the
parent directory changes, the old filehandle becomes stale.

Cheers,
  Trond
