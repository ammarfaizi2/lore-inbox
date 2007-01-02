Return-Path: <linux-kernel-owner+w=401wt.eu-S1755269AbXABO0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbXABO0v (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 09:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbXABO0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 09:26:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41133 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260AbXABO0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 09:26:50 -0500
Date: Tue, 2 Jan 2007 14:26:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-aio@kvack.org, akpm@osdl.org,
       drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
Subject: Re: [FSAIO][PATCH 6/8] Enable asynchronous wait page and lock page
Message-ID: <20070102142627.GA14954@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>, linux-aio@kvack.org,
	akpm@osdl.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20061228084149.GF6971@in.ibm.com> <20061228115510.GA25644@infradead.org> <20061228144717.GA10156@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228144717.GA10156@in.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 08:17:17PM +0530, Suparna Bhattacharya wrote:
> I am really bad with names :(  I tried using the _wq suffixes earlier and
> that seemed confusing to some, but if no one else objects I'm happy to use
> that. I thought aio_lock_page() might be misleading because it is
> synchronous if a regular wait queue entry is passed in, but again it may not
> be too bad.
> 
> What's your preference ? Does anything more intuitive come to mind ?

Beein bad about naming seems to be a disease, at least I suffer from it
aswell.  I wouldn't mind either the _wq or aio_ naming - _wq describes
the way it's called and aio_ describes it's a special case for aio.
Similarly to how ->aio_read/->aio_write can be used for synchronous I/O
aswell.

