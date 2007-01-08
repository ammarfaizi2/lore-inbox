Return-Path: <linux-kernel-owner+w=401wt.eu-S1750820AbXAHX6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbXAHX6X (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbXAHX6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:58:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58805 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750820AbXAHX6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:58:21 -0500
Date: Tue, 9 Jan 2007 10:57:45 +1100
From: David Chinner <dgc@sgi.com>
To: Christoph Hellwig <hch@infradead.org>, David Chinner <dgc@sgi.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make BH_Unwritten a first class bufferhead flag
Message-ID: <20070108235745.GD33919298@melbourne.sgi.com>
References: <20070108224932.GZ33919298@melbourne.sgi.com> <20070108225402.GA24787@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108225402.GA24787@infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 10:54:02PM +0000, Christoph Hellwig wrote:
> this doesn't look like a full first class flag to me yet.  Don't
> we need to check for buffer_unwritten in the places we're checking
> for buffer_delay so we can stop setting buffer_delay for unwritten
> buffers?

That would be __block_prepare_write() and block_truncate_page()?
I can't see anywhere else in the code where buffer_delay is used
outside XFS....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
