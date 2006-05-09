Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWEISCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWEISCk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 14:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWEISCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 14:02:40 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:20433 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750839AbWEISCk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 14:02:40 -0400
Subject: [PATCH 0/3] VFS changes to collapse AIO and vectored IO  into
	single (set of) fileops.
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
Cc: christoph <hch@lst.de>, Benjamin LaHaise <bcrl@kvack.org>,
       cel@citi.umich.edu, pbadari@us.ibm.com
In-Reply-To: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 09 May 2006 11:03:45 -0700
Message-Id: <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These series of patches collapses all the vectored IO support into
single set of file-operation method using aio_read/aio_write.
This work was originally suggested & started by Christoph Hellwig,
when Zach Brown tried to add vectored support for AIO.

Here is the summary:

[PATCH 1/3] Vectorize aio_read/aio_write methods

[PATCH 2/3] Remove readv/writev methods and use aio_read/aio_write
instead.

[PATCH 3/3] Zach's core aio changes to support vectored AIO.

BTW, Chuck Lever is actually re-arranging NFS DIO, AIO code to
fit into this model. 

Thanks to Chuck Lever and Shaggy for tracking down the latest
set of issues :)

I ran various testing including LTP on this series. Andrew,
can you include these in -mm tree ?

Thanks,
Badari


