Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWEPKvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWEPKvc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 06:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWEPKvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 06:51:32 -0400
Received: from verein.lst.de ([213.95.11.210]:13542 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751769AbWEPKvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 06:51:31 -0400
Date: Tue, 16 May 2006 12:50:43 +0200
From: christoph <hch@lst.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, akpm@osdl.org,
       christoph <hch@lst.de>, Benjamin LaHaise <bcrl@kvack.org>,
       cel@citi.umich.edu, Zach Brown <zach.brown@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] Streamline generic_file_* interfaces and filemap cleanups
Message-ID: <20060516105042.GA18214@lst.de>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com> <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com> <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com> <1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com> <1147728206.6181.7.camel@dyn9047017100.beaverton.ibm.com> <20060516082804.F5598@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516082804.F5598@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 08:28:04AM +1000, Nathan Scott wrote:
> I know its not something you're introducing here, but the naming
> convention do_sync_read/do_sync_write is pretty confused (with it
> not actually being a sync write and all, in the usual case).
> Any chance that could be renamed to something thats a bit clearer,
> maybe generic_file_non_aio_read and generic_file_non_aio_write?
> There don't seem to be many callsites (so not a huge change) and
> it'd seem a good time to do it, alongside these other changes.

I agree that the current naming is rather odd.  generic_file_* on the
other hand would be completely wrong  - generic_file_* are the generic
pagecache routines, these are wrappers to use ->aio_read/->aio_write.

Currently I can't imagine a better name, though.

