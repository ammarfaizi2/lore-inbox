Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265102AbUELOwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUELOwS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 10:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265103AbUELOwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 10:52:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52148 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265102AbUELOwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 10:52:16 -0400
Date: Wed, 12 May 2004 10:52:07 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Michal Ludvig <michal@logix.cz>
cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Support for VIA PadLock crypto engine
In-Reply-To: <Pine.LNX.4.53.0405121546200.24118@maxipes.logix.cz>
Message-ID: <Xine.LNX.4.44.0405121046250.11214-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004, Michal Ludvig wrote:

> In fact I believe that the hardware-specific drivers (e.g. the S/390 one)
> should be used in the cryptoapi as well and then the kernel should provide
> a single, universal device with read/write/ioctl calls for all of them.
> Not making a separete device for every piece of hardware on the market.
> Am I wrong?

Providing a userspace API is an orthogonal issue, and really needs to be 
designed in conjunction with the async hardware API.

What I am suggesting is that you simply implement something like 
des_z990.c so that C3 users can load crypto alg modules which use their 
hardware.

- James
-- 
James Morris
<jmorris@redhat.com>


