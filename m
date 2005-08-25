Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbVHYJe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbVHYJe2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 05:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbVHYJe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 05:34:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8603 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751408AbVHYJe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 05:34:28 -0400
Date: Thu, 25 Aug 2005 10:34:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kumar Gala <galak@freescale.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 00/15] Remove asm/segment.h from low hanging	architectures
Message-ID: <20050825093424.GA10409@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Zachary Amsden <zach@vmware.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Kumar Gala <galak@freescale.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net> <1124920244.13833.6.camel@localhost.localdomain> <430D8E68.7070303@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430D8E68.7070303@vmware.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 02:24:56AM -0700, Zachary Amsden wrote:
> Yes, agree totally,  i386 _requires_ asm/segment.h.  It is used in 
> low-level trap handling and bootup code from assembly files.  In 
> addition,

but keeping the header under that name will just encorage people
to put it back into drivers, after all it compiles on i386..

Let's rename it even for i386.

>even parts of userspace on i386 depend on asm/segment.h, 
> although that is a different beast.

That's a problem of glibc-kernheaders (or insert alternative $name here)

