Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTESJ3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 05:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTESJ3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 05:29:22 -0400
Received: from verein.lst.de ([212.34.181.86]:14351 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261932AbTESJ3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 05:29:21 -0400
Date: Mon, 19 May 2003 11:42:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jaroslav Kysela <perex@suse.cz>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove 2.2 compat cruft from sound/
Message-ID: <20030519114217.A4325@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Jaroslav Kysela <perex@suse.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20030518181551.A28588@lst.de> <Pine.LNX.4.44.0305191041540.21997-100000@pnote.perex-int.cz> <20030519113856.A4282@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030519113856.A4282@lst.de>; from hch@lst.de on Mon, May 19, 2003 at 11:38:56AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 11:38:56AM +0200, Christoph Hellwig wrote:
> On Mon, May 19, 2003 at 10:44:46AM +0200, Jaroslav Kysela wrote:
> > We still support the 2.2 kernel. We are trying to separate this 
> > "compatibility" code to another location, but in some cases, it is 
> > difficult. Please, make changes only for /sound/oss tree. Thank you.
> 
> I sterongly disagree.  As part of having your code in mainline you
> have to keep it readable.  Neither the compat mess nor the typedef
> abuse help on this.
> 

And it's not like the 2.2 code was actually working, e.g. the dropping
of i_sem in ->write makes you allow multiple simultanous writes, your
module refcounting on 2.2 is completly b0rked due to the lack of ->owner
and many functions have change parameters..
