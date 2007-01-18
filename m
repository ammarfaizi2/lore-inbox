Return-Path: <linux-kernel-owner+w=401wt.eu-S1751923AbXAREXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbXAREXj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 23:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbXAREXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 23:23:39 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:59973 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbXAREXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 23:23:38 -0500
Date: Thu, 18 Jan 2007 09:57:31 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, pbadari@us.ibm.com
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Vectored AIO breakage for sockets and pipes ?
Message-ID: <20070118042731.GA15859@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com> <20070116015450.9764.52713.patchbomb.py@nate-64.agami.com> <20070116021438.GA15774@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070116021438.GA15774@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The call to aio_advance_iovec() in aio_rw_vect_retry() becomes problematic
when it comes to pipe and socket operations which internally modify/advance
the iovec themselves. As a result AIO writes to sockets fail to return
the correct result. 

I'm not sure what the best way to fix this is. One option is to always make
a copy of the iovec and pass that down. Any other thoughts ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

