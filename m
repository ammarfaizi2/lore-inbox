Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbUKRRzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbUKRRzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbUKRRxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:53:31 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:26601 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262828AbUKRRwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:52:35 -0500
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
	using SELinux and SOCK_SEQPACKET
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Morris <jmorris@redhat.com>
Cc: Ross Kendall Axe <ross.axe@blueyonder.co.uk>, netdev@oss.sgi.com,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Xine.LNX.4.44.0411180305060.3192-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0411180305060.3192-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100796518.6019.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 18 Nov 2004 16:49:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-11-18 at 08:27, James Morris wrote:
> 2) Ensure that unix_dgram_sendmsg() fails for SOCK_SEQPACKET sockets which
> are not connected, otherwise someone could bypass LSM by sending on an
> unconnected socket.

What about half closed and other connected states ? This patch seems
inadequate for things like X.25


