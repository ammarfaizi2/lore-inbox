Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTFKCXZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 22:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbTFKCXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 22:23:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33472 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264015AbTFKCXY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 22:23:24 -0400
Date: Wed, 11 Jun 2003 03:37:06 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Frank Cusack <fcusack@fcusack.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@transmeta.com,
       marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
Message-ID: <20030611023706.GD6754@parcelfarce.linux.theplanet.co.uk>
References: <20030603165438.A24791@google.com> <shswug2sz5x.fsf@charged.uio.no> <20030604142047.C24603@google.com> <16094.25720.895263.4398@charged.uio.no> <20030603165438.A24791@google.com> <20030609065141.A9781@google.com> <20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk> <20030610182824.A18280@google.com> <20030611014717.GB6754@parcelfarce.linux.theplanet.co.uk> <20030610193243.A18623@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610193243.A18623@google.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 07:32:43PM -0700, Frank Cusack wrote:

> But anyway you do agree that the one line fix is correct?  You may have
> gotten thrown off track because of my somewhat broken description.

As far as I can see, it doesn't solve the real problem.  E.g. it allows
you to create all sorts of fun for async-unlink code in NFS - the thing
pretty much assumes that victim dentry is not going anywhere.
