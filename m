Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVCBHu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVCBHu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 02:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVCBHu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 02:50:56 -0500
Received: from hera.cwi.nl ([192.16.191.8]:33419 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262215AbVCBHuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 02:50:46 -0500
Date: Wed, 2 Mar 2005 08:50:38 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, torvalds@osdl.org, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
Message-ID: <20050302075037.GH20190@apps.cwi.nl>
References: <20050228192001.GA14221@apps.cwi.nl> <1109721162.15795.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109721162.15795.47.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 11:52:44PM +0000, Alan Cox wrote:
> On Llu, 2005-02-28 at 19:20, Andries Brouwer wrote:
> > One such case is the mtrr code, where struct mtrr_ops has an
> > init field pointing at __init functions. Unless I overlook
> > something, this case may be easy to settle, since the .init
> > field is never used.
> 
> The failure to invoke the ->init operator appears to be the bug.
> The centaur code definitely wants the mcr init function to be called.

Yes, I expected that to be the answer. Therefore #if 0 instead of deleting.
But if calling ->init() is needed, and it has not been done the past
three years, the question arises whether there are any users.

Andries

