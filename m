Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbUBUAHY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUBUAHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:07:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19935 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261442AbUBUAHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:07:16 -0500
Date: Fri, 20 Feb 2004 19:07:27 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Christophe Saout <christophe@saout.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
In-Reply-To: <1077316812.24726.5.camel@leto.cs.pocnet.net>
Message-ID: <Xine.LNX.4.44.0402201905370.7902-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004, Christophe Saout wrote:

> What do you think of this?
> 
> I would like to copy the tfm onto the stack so that I can
> a) compute the hmac on several CPUs at the same time without locking
> b) reuse a precomputed tfm from just after crypt_hmac_init

I think you'll run into problems on highmem boxes when the code kmaps 
pages.  IIRC, Matt Mackall has looked into this in detail.


- James
-- 
James Morris
<jmorris@redhat.com>


