Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVDFXTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVDFXTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 19:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVDFXTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 19:19:31 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:17305 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262347AbVDFXT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 19:19:28 -0400
Date: Thu, 7 Apr 2005 09:19:06 +1000
From: Greg Banks <gnb@sgi.com>
To: Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make sense
Message-ID: <20050406231906.GA4473@sgi.com>
References: <20050406160123.GH347@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050406160123.GH347@unthought.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2005 at 06:01:23PM +0200, Jakob Oestergaard wrote:
> 
> Problem; during simple tests such as a 'cp largefile0 largefile1' on the
> client (under the mountpoint from the NFS server), the client becomes
> extremely laggy, NFS writes are slow, and I see very high CPU
> utilization by bdflush and rpciod.
> 
> For example, writing a single 8G file with dd will give me about
> 20MB/sec (I get 60+ MB/sec locally on the server), and the client rarely
> drops below 40% system CPU utilization.

How large is the client's RAM?  What does the following command report
before and during the write?

egrep 'nfs_page|nfs_write_data' /proc/slabinfo

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
