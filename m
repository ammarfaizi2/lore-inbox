Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264777AbUFGPwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbUFGPwE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbUFGPwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:52:03 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:24704 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264811AbUFGPvv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:51:51 -0400
Subject: Re: [BUG] NFS no longer updates file modification times
	appropriately
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: joe.korty@ccur.com
Cc: linux-kernel@vger.kernel.org, Ronny.Lampert@telecasystems.de,
       ioe-lkml@rameria.de
In-Reply-To: <20040607152139.GA21926@tsunami.ccur.com>
References: <1086297112.3659.3.camel@lade.trondhjem.org>
	 <20040607152139.GA21926@tsunami.ccur.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1086623509.4173.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 07 Jun 2004 11:51:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 07/06/2004 klokka 11:21, skreiv Joe Korty:

> Unless the real reason is reducing ethernet traffic.

That is after all, why we cache data. Look at the GETATTR traffic using
nfsstat.

>   In which case we
> could defer a timestamp-on-write only when it is still in the same second
> as the previous write, but don't defer when a new second rolls around
> on the client.  That would reduce timestamp updates to at most one per
> second per inode per client, while preserving old NFS behavior.

Exactly why should we go to all this trouble?

Cheers,
   Trond
