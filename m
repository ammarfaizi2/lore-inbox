Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbTEETKS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 15:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbTEETKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 15:10:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21704 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261235AbTEETKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 15:10:18 -0400
Date: Mon, 5 May 2003 20:22:48 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove unused funcion proc_mknod
Message-ID: <20030505192248.GD10374@parcelfarce.linux.theplanet.co.uk>
References: <20030505190045.A22238@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505190045.A22238@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 07:00:45PM +0200, Christoph Hellwig wrote:
> Not used currently and a rather bad idea in general..

That is true, but note that ALAS^H^HSA creates device nodes in /proc
manually.  IOW, removal of proc_mknod() won't solve anything.  The
real question is whether we should allow device nodes on procfs.
If we should not allow them, ALSA needs API changes.  If we should,
it'd be better to have creation of such nodes explicit (and if ALSA
keeps doing that, it should switch to calling proc_mknod()).
