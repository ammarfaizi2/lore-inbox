Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267765AbTGLGhd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 02:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267768AbTGLGhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 02:37:33 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:59396 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267765AbTGLGhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 02:37:32 -0400
Date: Sat, 12 Jul 2003 07:52:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Bernardo Innocenti <bernie@develer.com>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: do_div vs sector_t
Message-ID: <20030712075202.A1327@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@debian.org>,
	Bernardo Innocenti <bernie@develer.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <20030711223359.GP20424@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030711223359.GP20424@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Fri, Jul 11, 2003 at 11:33:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 11:33:59PM +0100, Matthew Wilcox wrote:
>                         aic->seek_mean = aic->seek_total + 128;
>                         do_div(aic->seek_mean, aic->seek_samples);
>                 }
> 
> seek_mean is a sector_t so sometimes it's 64-bit on a 32-bit platform.
> so we can't avoid calling do_div().

That's why we have sector_div, never use do_div on a sector_t.

