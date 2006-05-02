Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWEBPG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWEBPG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWEBPG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:06:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:62339 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964872AbWEBPG1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:06:27 -0400
Subject: [PATCH 0/3] VFS changes to collapse AIO and vectored IO  into
	single (set of) fileops.
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, Zach Brown <zach.brown@oracle.com>, christoph <hch@lst.de>,
       Benjamin LaHaise <bcrl@kvack.org>, pbadari@us.ibm.com,
       cel@citi.umich.edu
Content-Type: text/plain
Date: Tue, 02 May 2006 08:07:18 -0700
Message-Id: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
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

I ran various testing including LTP on this series. Andrew,
can you include these in -mm tree ?

Thanks,
Badari


