Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbUKSMp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbUKSMp3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUKSMnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 07:43:43 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:53228 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261394AbUKSMn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 07:43:29 -0500
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
	using SELinux and SOCK_SEQPACKET
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Morris <jmorris@redhat.com>
Cc: Ross Kendall Axe <ross.axe@blueyonder.co.uk>, netdev@oss.sgi.com,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Xine.LNX.4.44.0411182207080.7831-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0411182207080.7831-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100864358.8127.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 19 Nov 2004 11:39:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-11-19 at 03:12, James Morris wrote:
> On Thu, 18 Nov 2004, Alan Cox wrote:
> 
> > As to the other stuff I think the only change needed is to check the
> > queued asynchronous error and report that before going on to the
> > connected test
> 
> How about this?

Looks right to me, the ECONNRESET is no longer being lost.
