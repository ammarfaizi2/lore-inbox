Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbUKSHNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbUKSHNR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 02:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbUKSHNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 02:13:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38080 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261287AbUKSHNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 02:13:12 -0500
Date: Fri, 19 Nov 2004 02:12:58 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ross Kendall Axe <ross.axe@blueyonder.co.uk>, <netdev@oss.sgi.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
 using SELinux and SOCK_SEQPACKET
In-Reply-To: <20041118230109.V2357@build.pdx.osdl.net>
Message-ID: <Xine.LNX.4.44.0411190209090.8343-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Chris Wright wrote:

> > (Also now ignores any supplied address per 
> > http://www.opengroup.org/onlinepubs/009695399/functions/sendto.html)
> 
> Nitpick, but I missed where it said ignore the address.  And it seems
> counter intuitive to provide address, only to have it ignored and
> delivered elsewhere.

For sendto():
  "If the socket is connection-mode, dest_addr shall be ignored."

For sendmsg():
  "If the socket is connection-mode, the destination address in msghdr 
   shall be ignored."

I agree that it's counter intuitive (and surely an application bug), but
some feedback I've had suggests we follow the spec.


- James
-- 
James Morris
<jmorris@redhat.com>


