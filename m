Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266571AbUFYIcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266571AbUFYIcH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 04:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266567AbUFYIcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 04:32:07 -0400
Received: from [213.146.154.40] ([213.146.154.40]:53940 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266598AbUFYIbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 04:31:35 -0400
Date: Fri, 25 Jun 2004 09:31:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-ID: <20040625083130.GA26557@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Erik Jacobson <erikj@subway.americas.sgi.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
References: <Pine.SGI.3.96.1040623094239.19458C-100000@fsgi900.americas.sgi.com> <20040623143801.74781235.akpm@osdl.org> <200406231754.56837.jbarnes@engr.sgi.com> <Pine.SGI.4.53.0406242153360.343801@subway.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.53.0406242153360.343801@subway.americas.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 10:15:41PM -0500, Erik Jacobson wrote:
> Andrew and LKML folks -
> 
> Pat is on vacation and said he wouldn't mind if I posted the latest version
> of this patch.
> 
>  - I fixed up Kconfig (x86 problem)
>  - I changed SYSFS_ONLY to USE_DYNAMIC_MINOR

Please kill the ifdef completely.  As long as LANANA hasn't responded you
should only use the dyanic nimor, and once it's accepted there's no point
in using the dynamico ne anymore.  Also I'd sugges grabbing a whole dyanmic
major instead of using a miscdevice so the code both cases is more similar.

