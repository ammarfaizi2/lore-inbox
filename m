Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUJNQv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUJNQv0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 12:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266807AbUJNQv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 12:51:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41894 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266802AbUJNQvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 12:51:23 -0400
Subject: Re: ext3 error with 2.6.9-rc4
From: "Stephen C. Tweedie" <sct@redhat.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Andreas Dilger <adilger@clusterfs.com>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20041012142943.GD920@zip.com.au>
References: <20041012142943.GD920@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1097772670.2120.57.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Oct 2004 17:51:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2004-10-12 at 15:29, CaT wrote:
> The fs is on a 200gb seagate hd on a promise pci card (20267 - latest
> firmware). It's hdh1. I was tarring a fs on hde1 onto hdh1. It ran for a
> bit and then stopped with my kern.log providing the following error:
> 
> Oct 13 00:12:03 nessie kernel: EXT3-fs: mounted filesystem with ordered data mode.
> Oct 13 00:17:03 nessie kernel: EXT3-fs error (device hdh1): ext3_readdir: bad entry in directory #3522561: rec_len is smaller than minimal - offset=4084, inode=3523431, rec_len=0, name_len=0

All this really tells us is that there's something bogus on disk, not
how it got there.  

There are tools like "dt" which may help identify whether there's data
going bad on the way to disk, or whether it might be a fs fault.

http://www.bit-net.com/~rmiller/dt.html

--Stephen

