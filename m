Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270938AbTGQPqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 11:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270963AbTGQPqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 11:46:23 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:15622 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270938AbTGQPqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 11:46:21 -0400
Date: Thu, 17 Jul 2003 17:01:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usability of device nodes with devfs
Message-ID: <20030717170101.A9432@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
References: <200307161642.05966.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307161642.05966.oliver@neukum.org>; from oliver@neukum.org on Wed, Jul 16, 2003 at 04:42:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 04:42:05PM +0200, Oliver Neukum wrote:
> Hi,
> 
> is it a requirement that nodes created with devfs can be opened
> successfully from the moment the device is registered?

For 2.4 which has a direct connection from devfs entries to file operations
this is indeed a requirement.  For 2.5 devfs is merely a way to perform
mknod from kernelspace so there is no such requirement.  Just still have
to be setup for I/O when calling register_chardev/add_disk, though.

