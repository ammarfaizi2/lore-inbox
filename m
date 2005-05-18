Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVERPlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVERPlV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVERPhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:37:23 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:14252 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262281AbVERPg6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:36:58 -0400
Message-ID: <428B6111.3000802@freenet.de>
Date: Wed, 18 May 2005 17:36:49 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 1/5] bdev: execute in place (V2)
References: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com> <1116424403.2202.16.camel@cotte.boeblingen.de.ibm.com> <20050518142739.GB23162@infradead.org>
In-Reply-To: <20050518142739.GB23162@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>>+	int (*direct_access) (struct inode *, sector_t, unsigned long *);
>>    
>>
>
>this should have a block_device * first argument.
>  
>
While I agree that (block_device *) would be a good thing to address
the target block device, the inode *  is consistent with other
operations in this vector: open, release, & ioctl use the same scheme.
The reason for inode * here is that the caller has no easy way to get
to the block_device *. How would the filesystem do that?
