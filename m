Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268003AbUHFFou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268003AbUHFFou (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 01:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268098AbUHFFou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 01:44:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59785 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268003AbUHFFom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 01:44:42 -0400
Date: Fri, 6 Aug 2004 07:44:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
Message-ID: <20040806054424.GB10274@suse.de>
References: <20040730193651.GA25616@bliss> <20040731153609.GG23697@suse.de> <20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de> <20040731210257.GA22560@bliss> <20040805054056.GC10376@suse.de> <1091739966.8418.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091739966.8418.38.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05 2004, Alan Cox wrote:
> On Iau, 2004-08-05 at 06:40, Jens Axboe wrote:
> > Ok, that is definitely more acceptable. But then it should be done to
> > CDROM_SEND_PACKET as well, and we risk breaking programs doing so (ie
> > cdrecord run by user currently).
> 
> Definitely. Irrespective of any questions like filtering commands having
> /dev device access allow you to compromise the entire system is not a
> good model. CAP_SYS_RAWIO is the capability for "can do anything" so
> seems appropriate here.

We risk breaking lots of programs, but it might be the best option yes.

-- 
Jens Axboe

