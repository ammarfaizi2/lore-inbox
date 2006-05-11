Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWEKTLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWEKTLK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 15:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWEKTLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 15:11:10 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:12732 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750720AbWEKTLI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 15:11:08 -0400
Subject: Re: [PATCH 1/4] Vectorize aio_read/aio_write methods
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, christoph <hch@lst.de>,
       Benjamin LaHaise <bcrl@kvack.org>, cel@citi.umich.edu
In-Reply-To: <20060511115251.5e008c5d.akpm@osdl.org>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	 <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	 <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
	 <1147361939.12117.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060511115251.5e008c5d.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 11 May 2006 12:12:06 -0700
Message-Id: <1147374726.12421.27.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-11 at 11:52 -0700, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > +	size_t count = 0;
> > +
> > +	for (seg = 0; seg < nr_segs; seg++)
> > +		count += iov[seg].iov_len;
> 
> We have iov_length() for this.  pls review all patches, send updates if
> appropriate.
> 

Will do. That was temporarily added for handling NFS. Chuck needs
to re-write those portions to handle the vectors anyway.

Thanks,
Badari

