Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262807AbVEHDx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbVEHDx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 23:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVEHDx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 23:53:29 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:25991 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262807AbVEHDx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 23:53:27 -0400
Subject: Re: Suspend/Resume
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Jon Escombe <trial@dresco.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050503141017.GD6115@suse.de>
References: <4267B5B0.8050608@davyandbeth.com>
	 <loom.20050502T161322-252@post.gmane.org> <20050502144703.GA1882@suse.de>
	 <loom.20050502T221228-244@post.gmane.org>  <20050503141017.GD6115@suse.de>
Content-Type: text/plain
Date: Sat, 07 May 2005 22:53:21 -0500
Message-Id: <1115524401.5942.13.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-03 at 16:10 +0200, Jens Axboe wrote:
> I don't know, depends on what Jeff/James think of this approach. There
> are many different way to solve this problem. I let the scsi bus called
> suspend/resume for the devices on that bus, and let the scsi host
> adapter perform any device dependent actions. The pci helpers are less
> debatable.
> 
> Jeff/James? Here's a patch that applies to current git.

The patch looks fine as far as it goes ... however, shouldn't we be
spinning *internal* suspended drives down as well like IDE does (i.e. at
least the sd ULD needs to be a party to the suspend)?  Of course this is
a complete can of worms since we really have no idea which busses are
internal and which are external, although it might be something that
userland can determine.

James

P.S.  I noticed the gratuitous coding style corrections ...


