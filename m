Return-Path: <linux-kernel-owner+w=401wt.eu-S1751331AbXAIKuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbXAIKuM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbXAIKuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:50:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53756 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbXAIKuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:50:09 -0500
Date: Tue, 9 Jan 2007 10:50:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Chinner <dgc@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make BH_Unwritten a first class bufferhead flag
Message-ID: <20070109105007.GA22531@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Chinner <dgc@sgi.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20070108224932.GZ33919298@melbourne.sgi.com> <20070108225402.GA24787@infradead.org> <20070108235745.GD33919298@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108235745.GD33919298@melbourne.sgi.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 10:57:45AM +1100, David Chinner wrote:
> On Mon, Jan 08, 2007 at 10:54:02PM +0000, Christoph Hellwig wrote:
> > this doesn't look like a full first class flag to me yet.  Don't
> > we need to check for buffer_unwritten in the places we're checking
> > for buffer_delay so we can stop setting buffer_delay for unwritten
> > buffers?
> 
> That would be __block_prepare_write() and block_truncate_page()?
> I can't see anywhere else in the code where buffer_delay is used
> outside XFS....

Yes, I think it's just those two.
