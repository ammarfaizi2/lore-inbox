Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266141AbUHDPqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbUHDPqk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 11:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUHDPqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 11:46:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57041 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266141AbUHDPqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 11:46:37 -0400
Date: Wed, 4 Aug 2004 08:44:29 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: block layer sg, bsg
Message-Id: <20040804084429.7de77cd7.davem@redhat.com>
In-Reply-To: <20040804150403.GU10340@suse.de>
References: <20040804085000.GH10340@suse.de>
	<20040804075215.155c06ac.davem@redhat.com>
	<20040804150403.GU10340@suse.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004 17:04:04 +0200
Jens Axboe <axboe@suse.de> wrote:

> On Wed, Aug 04 2004, David S. Miller wrote:
> > 
> > When you pass data structures in via {read,write}{,v}() system calls,
> > you make it next to impossible for the CONFIG_COMPAT layer to cope
> > with this.
> > 
> > Please consider another way to pass in those sg_io_* things.
> 
> Any suggestions?

ioctl() :-(

Or use a more portable well-defined type which does not change
size nor layout between 32-bit and 64-bit environments.
