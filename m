Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTEIKkd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 06:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTEIKkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 06:40:33 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:1293 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262434AbTEIKkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 06:40:32 -0400
Date: Fri, 9 May 2003 11:53:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ralf Oehler <R.Oehler@GDAmbH.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: missing get_empty_inode()
Message-ID: <20030509115309.B18745@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ralf Oehler <R.Oehler@GDAmbH.com>, linux-kernel@vger.kernel.org
References: <XFMail.20030509112703.R.Oehler@GDAmbH.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <XFMail.20030509112703.R.Oehler@GDAmbH.com>; from R.Oehler@GDAmbH.com on Fri, May 09, 2003 at 11:27:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 11:27:03AM +0200, Ralf Oehler wrote:
> Hello, list
> 
> Currently I'm porting my driver sources from 2.4.18 to 2.4.20 an I noticed
> the absence of get_empty_inode().
> I didn't find an exported function to get a sb-less inode.

There is none.  Inodes must have superblocks associated to them.

> My goal is to open sd- and an sg- devices in order to do
> ioctl(send_scsi_cmd) on them. As my driver acts as a block device driver
> (layered pseudo block device), there is no sb assigned to it.
> 
> What is, according to the current philosophy, the cleanest code-sniplet to
> 
> - open
> - ioctl
> - close
> 
> an sd-device ?
> an sg-device ?

open it from userspace.

