Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbUERBtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUERBtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 21:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUERBtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 21:49:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:44991 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262213AbUERBtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 21:49:04 -0400
Date: Mon, 17 May 2004 18:46:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Robert.Picco@hp.com, linux-kernel@vger.kernel.org,
       venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] HPET driver
Message-Id: <20040517184621.0da52a3c.akpm@osdl.org>
In-Reply-To: <40A94DF7.30307@pobox.com>
References: <40A3F805.5090804@hp.com>
	<40A40204.1060509@pobox.com>
	<40A93DA5.4020701@hp.com>
	<20040517160508.63e1ddf0.akpm@osdl.org>
	<20040517161212.659746db.akpm@osdl.org>
	<40A94857.9030507@pobox.com>
	<20040517163356.506a9c8f.akpm@osdl.org>
	<40A94DF7.30307@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Andrew Morton wrote:
> > It's only applicable to 32-bit machines.  I thik I'd prefer to let the
> > various arch maintainers decide if this is an appropriate implementation.
> 
> 
> Agreed, though I observe it's mostly 32-bit architectures that are 
> missing readq() and writeq() implementations...
> 

s2io.h has a private readq/writeq implementation, which I'm removing. 
There are probably others around the place (haven't looked).

This means that architecture implementation of readq()/writeq() becomes
non-optional.
