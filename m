Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbUKRRQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbUKRRQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbUKRRNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:13:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53937 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262779AbUKRRL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:11:26 -0500
Date: Thu, 18 Nov 2004 12:11:18 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: Ross Kendall Axe <ross.axe@blueyonder.co.uk>, <netdev@oss.sgi.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
 using SELinux and SOCK_SEQPACKET
In-Reply-To: <20041118090706.O2357@build.pdx.osdl.net>
Message-ID: <Xine.LNX.4.44.0411181209380.5179-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Chris Wright wrote:

> Right, but the snippet I posted guards against that I think.  It forces
> unix_peer_get() in dgram_sendmsg.

Correct.  We could also add more code to dgram_sendmsg() to simply ignore
any address passed in for SOCK_SEQPACKETs, but again, I think that is a
programming error and I think we should signal that, especially as this is
a new feature.



- James
-- 
James Morris
<jmorris@redhat.com>


