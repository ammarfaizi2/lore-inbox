Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVFNN77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVFNN77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 09:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVFNN77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 09:59:59 -0400
Received: from gate.corvil.net ([213.94.219.177]:35601 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261212AbVFNN7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 09:59:55 -0400
Message-ID: <42AEE2D5.50902@draigBrady.com>
Date: Tue, 14 Jun 2005 14:59:49 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bert hubert <bert.hubert@netherlabs.nl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: optimal file order for reading from disk
References: <42AEBDC4.2050907@draigBrady.com> <20050614121320.GA4739@outpost.ds9a.nl>
In-Reply-To: <20050614121320.GA4739@outpost.ds9a.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> On Tue, Jun 14, 2005 at 12:21:40PM +0100, P@draigBrady.com wrote:
> 
>>I know this will be dependent on filesystem, I/O scheduler, ...
>>but given a list of files, what is the best (filesystem
>>agnostic) order to read from disk (to minimise seeks).
>>
>>Should I sort by path, inode number, getdents, or something else?
> 
> I know several projects that sort on inode number and benefit from that,
> sometimes in a big way. The effect of this will probably be less on a
> matured filesystem image.

Thanks for that. Yep I'm torn between sorting by inode which
should be good for new filesystems, but maybe sorting by
path would be better for mature filesystems?

> I can't really explain why it helps though. I don't think the kernel will do
> 'crossfile readahead', although your disk might do so.
> 
> Google on 'orlov allocator', is enlightning.

I found some interesting into here thanks:
http://kerneltrap.org/node/2157

cheers,
Pádraig.
