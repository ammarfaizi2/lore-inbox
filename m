Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266065AbUFDXiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266065AbUFDXiF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUFDXiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:38:05 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:29057 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S266065AbUFDXh4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:37:56 -0400
Subject: Re: [BUG] NFS no longer updates file modification times  
	appropriately
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040604162410.569c7ecc@dell_ss3.pdx.osdl.net>
References: <1086297112.3659.3.camel@lade.trondhjem.org>
	 <20040604132355.GA31710@tsunami.ccur.com>
	 <1086390495.4161.43.camel@lade.trondhjem.org>
	 <20040604162410.569c7ecc@dell_ss3.pdx.osdl.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1086392275.4161.52.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 04 Jun 2004 19:37:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 04/06/2004 klokka 19:24, skreiv Stephen Hemminger:

> What about fsync()?

There were no changes to fsync() between 2.6.5 and 2.6.6. In any case,
Joe's test program did not use fsync() (that was very much the problem).
Any use of either close() or fsync() on the client will cause the
mtime/ctime to be updated on the server, and that change should
immediately propagate back to the client.

Cheers,
  Trond
