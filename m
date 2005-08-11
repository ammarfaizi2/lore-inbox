Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbVHKLwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVHKLwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 07:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVHKLwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 07:52:06 -0400
Received: from pat.uio.no ([129.240.130.16]:34297 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932324AbVHKLwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 07:52:05 -0400
Subject: Re: fcntl(F GETLEASE) semantics??
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Michael Kerrisk <mtk-lkml@gmx.net>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org,
       sfr@canb.auug.org.au, michael.kerrisk@gmx.net
In-Reply-To: <19888.1123748055@www44.gmx.net>
References: <17146.43490.8672.13906@wombat.chubb.wattle.id.au>
	 <19888.1123748055@www44.gmx.net>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 07:51:45 -0400
Message-Id: <1123761105.8251.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.539, required 12,
	autolearn=disabled, AWL 2.27, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 11.08.2005 Klokka 10:14 (+0200) skreiv Michael Kerrisk:

> No.  The behavior in Linux recently, and arbitrarily (IMO) changed:

The change was NOT arbitrary. It was deliberate and for the reasons
stated.

The whole point of leases is to support CIFS oplocks for Samba and NFSv4
delegations in the kernel. Both have the same specific expected
behaviour.
The original deviates from that expected behaviour by allowing you to
get a shared lease when in a condition that does not allow actual
sharing.

Cheers,
  Trond

