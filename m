Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264766AbSJOT2m>; Tue, 15 Oct 2002 15:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264769AbSJOT2e>; Tue, 15 Oct 2002 15:28:34 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:58352 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264766AbSJOT2c>; Tue, 15 Oct 2002 15:28:32 -0400
Date: Tue, 15 Oct 2002 15:34:27 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Christoph Hellwig <hch@sgi.com>, akpm@digeo.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [RFC] iovec in ->aio_read/->aio_write
Message-ID: <20021015153427.A16156@redhat.com>
References: <20021015223315.A21139@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021015223315.A21139@sgi.com>; from hch@sgi.com on Tue, Oct 15, 2002 at 10:33:15PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 10:33:15PM -0400, Christoph Hellwig wrote:
> Proposed next steps:  Convert over all readv/writev users
> to aio_read/aio_write and remove the methods.  Implement
> aio_read/aio_write in all filesystems using the generic
> pagecache code and kill the "normal" generic_file_read
> and generic_file_write.
> 
> Comments?

Please not right now? ;-)  At least introduce it as aio_readv/aio_writev 
as currently the way we deal with iovecs uglifies a lot of code, with no 
benefit for the vast majority of applications.  As for killing 
generic_file_read/write and using the aio counterparts, that is the plan 
pending a bit more testing of things.  I want to get there step by step 
without breaking everything along the way.

		-ben
