Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266140AbUA1TlX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 14:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUA1TlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 14:41:23 -0500
Received: from ns.suse.de ([195.135.220.2]:7396 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266140AbUA1Tkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 14:40:51 -0500
Date: Wed, 28 Jan 2004 20:40:49 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: willy@debian.org, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
Message-Id: <20040128204049.627e6312.ak@suse.de>
In-Reply-To: <Pine.LNX.4.58.0401281129570.28145@home.osdl.org>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
	<Pine.LNX.4.58.0401271847440.10794@home.osdl.org>
	<20040128182003.GL11844@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0401281129570.28145@home.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004 11:33:33 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> For example, if checking for an error involves actually reading a value 
> from a bridge register, then that implies some _serious_ amount of 
> serialization and external CPU stuff.

Which is _extremly_ hard to do from an MCE handler ...

(currently all our MCE handlers are buggy because they can deadlock on the 
printk lock) 

-Andi
