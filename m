Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262536AbTC0Mjl>; Thu, 27 Mar 2003 07:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262539AbTC0Mjl>; Thu, 27 Mar 2003 07:39:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41142 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262536AbTC0Mjk>;
	Thu, 27 Mar 2003 07:39:40 -0500
Date: Thu, 27 Mar 2003 13:50:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Jan Knutar <jk@fornax.tk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre6
Message-ID: <20030327125037.GJ1823@suse.de>
References: <Pine.GSO.4.21.0303271140160.26358-100000@vervain.sonytel.be> <03032714015400.14109@polaris>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03032714015400.14109@polaris>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27 2003, Jan Knutar wrote:
> 
> > Is IDE in 2.4.x and 2.5.x now more or less in sync?
> 
> Hm, can we ever expect to get cd burning in 2.4.x on ide without 
> locking up the other device on the channel?

During execution of a single command, channel _will_ be locked. This is
not solvable in the driver, it's how ide works. During fixation, for
instance, the channel will be locked...

Now, if you are locked during the _entire_ burn, that points to an ide
scheduling.

-- 
Jens Axboe

