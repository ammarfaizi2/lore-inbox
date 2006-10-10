Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbWJJJTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbWJJJTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 05:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbWJJJTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 05:19:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26513 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965125AbWJJJTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 05:19:10 -0400
Date: Tue, 10 Oct 2006 10:19:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steve Lord <lord@xfs.org>
Cc: David Chinner <dgc@sgi.com>, linux-fsdevel@vger.kernel.org,
       linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
Subject: Re: Directories > 2GB
Message-ID: <20061010091904.GA395@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steve Lord <lord@xfs.org>, David Chinner <dgc@sgi.com>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, xfs@oss.sgi.com
References: <20061004165655.GD22010@schatzie.adilger.int> <452AC4BE.6090905@xfs.org> <20061010015512.GQ11034@melbourne.sgi.com> <452B0240.60203@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452B0240.60203@xfs.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 09:15:28PM -0500, Steve Lord wrote:
> Hi Dave,
> 
> My recollection is that it used to default to on, it was disabled
> because it needs to map the buffer into a single contiguous chunk
> of kernel memory. This was placing a lot of pressure on the memory
> remapping code, so we made it not default to on as reworking the
> code to deal with non contig memory was looking like a major
> effort.

Exactly.  The code works but tends to go OOM pretty fast at least
when the dir blocksize code is bigger than the page size.  I should
give the code a spin on my ppc box with 64k pages if it works better
there.

