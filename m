Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbTGIMQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 08:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbTGIMQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 08:16:59 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:22290 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265966AbTGIMQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 08:16:35 -0400
Date: Wed, 9 Jul 2003 13:31:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: marcelo@connectiva.com.br, trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: ->direct_IO API change in current 2.4 BK
Message-ID: <20030709133109.A23587@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	marcelo@connectiva.com.br, trond.myklebust@fys.uio.no,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got a nice XFS oops due to the direct_IO API change in
2.4.  Guys, this is a STABLE series and APIs are supposed to be exactly
that, _STABLE_.  If you really think O_DIRECT on NFS is soo important
please add a ->direct_IO2 for NFS like the reiserfs read_inode2 hack.

But what's the use of it anyway?  AFAIK it's mostly for whoracle setups
that have their data on netapps but that needs a certified vendor kernel
not mainline..
