Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266191AbUGZXqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266191AbUGZXqg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 19:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266192AbUGZXqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 19:46:36 -0400
Received: from mx01.netapp.com ([198.95.226.53]:59388 "EHLO mx01.netapp.com")
	by vger.kernel.org with ESMTP id S266191AbUGZXqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 19:46:10 -0400
From: Brian Pawlowski <beepy@netapp.com>
Message-Id: <200407262345.i6QNjtr11774@tooting.eng.netapp.com>
Subject: Re: ext3 and SPEC SFS Run rules.
In-Reply-To: <16645.36138.385234.785650@cse.unsw.edu.au> from Neil Brown at "Jul 27, 4 09:00:58 am"
To: neilb@cse.unsw.edu.au (Neil Brown)
Date: Mon, 26 Jul 2004 16:45:55 -0700 (PDT)
Cc: akpm@osdl.org, tigran@aivazian.fsnet.co.uk, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME++ PL40 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only place that I am aware of where we *do*not* return wcc data is
> for the WRITE request (which you have not listed).  As the underlying
> filesystem is left to do whatever locking it thinks is appropriate,
> and vfs_write does none, nfsd is not in a position to lock it itself
> against sys_write and so cannot record before and after stat
> information that is atomic w.r.t the update.

Without replaying conversations on V3 and wcc_ stuff I do believe that
long about 1993 or 1994 most decided that making the pre- and post-stat
info atomic w.r.t. the update was not "required" - because that would
be hard.

The WCC stuff is relegated to a hint to help detect conflicting
changes in that case I believe.

beepy

