Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbVHXMub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVHXMub (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 08:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbVHXMua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 08:50:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42980 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750934AbVHXMua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 08:50:30 -0400
Date: Wed, 24 Aug 2005 13:50:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Frederik Schueler <fs@lowpingbastards.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Patrick Mansfield <patmans@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: new qla2xxx driver breaks SAN setup with 2 controllers
Message-ID: <20050824125022.GA29817@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Frederik Schueler <fs@lowpingbastards.de>,
	Patrick Mansfield <patmans@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20050823112535.GB13391@mail.lowpingbastards.de> <20050823200040.GA8310@us.ibm.com> <20050824095520.GD13391@mail.lowpingbastards.de> <20050824100112.GA27216@infradead.org> <20050824124803.GE13391@mail.lowpingbastards.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824124803.GE13391@mail.lowpingbastards.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 02:48:03PM +0200, Frederik Schueler wrote:
> Hello,
> 
> On Wed, Aug 24, 2005 at 11:01:12AM +0100, Christoph Hellwig wrote:
> > > yes exactly, only the bootdrive LUN is registered after bootup. I have
> > > to selectively scsiadd the other LUNs if there is a gap between the 
> > > boot LUN (1-8 in our setup) and the shared storages (9-14). I don't
> > > consider this a bug though, I had to remove some devices otherwise, 
> > > and old drivers had to be patched to allow this at all.
> > 
> > Actually this sounds like a bug in your storage system.  It's probably
> > reporting to be only SCSI2 complicant, which doesn't make sense for
> > FC storage.  Please try the patch below:
> 
> [...]
> 
> Unfortunately this does not fix this issue, besides the SAN being 
> reported as a scsi3 device now.

Cane you add BLIST_SPARSELUN and BLIST_LARGELUN to the flags aswell?

