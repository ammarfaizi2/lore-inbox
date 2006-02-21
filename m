Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161468AbWBUKjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161468AbWBUKjT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 05:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161471AbWBUKjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 05:39:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41601 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161470AbWBUKjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 05:39:18 -0500
Date: Tue, 21 Feb 2006 10:39:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Request for export of truncate_complete_page
Message-ID: <20060221103917.GC19349@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Oleg Drokin <green@linuxhacker.ru>, linux-kernel@vger.kernel.org
References: <20060220223810.GD5733@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220223810.GD5733@linuxhacker.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 12:38:10AM +0200, Oleg Drokin wrote:
> Hello!
> 
>    Can I ask for truncate_complete_page() to be exported?
>    For Lustre filesystem it is necessary to poke out pages in the middle of
>    a file, but truncate_inode_pages() is not very suitable, because we
>    poke those pages one at a time when locks on those pages are cancelled, but
>    we cannot kill entire set of pages as a group, because there might be some
>    other lock that covers a subset of those pages, so we still need to iterate
>    through all of them, and while we are at it, it is easier to kill pages
>    as we check them one by one.

Truncating around inside a file is very fishy, so this would need a review
of cour code.  Once you submit the new lustre client we can discuss exporting
this as _GPL, before we won't export it anyway.

