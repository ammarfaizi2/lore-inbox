Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWB1RTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWB1RTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWB1RTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:19:54 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:4616 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932217AbWB1RTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:19:54 -0500
Message-ID: <440485E7.4090702@cfl.rr.com>
Date: Tue, 28 Feb 2006 12:18:31 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>, Andrew Morton <akpm@osdl.org>,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: GFS2 Filesystem [0/16]
References: <1140792511.6400.707.camel@quoit.chygwyn.com> <20060224213553.GA8817@infradead.org>
In-Reply-To: <20060224213553.GA8817@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2006 17:21:51.0011 (UTC) FILETIME=[76560F30:01C63C8B]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14295.000
X-TM-AS-Result: No--4.090000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a bit confused.  Why exactly is this unacceptable, and what exactly 
do you propose instead?  Having an entirely separate mount point that is 
sort of parallel to the main one, but with extra metadata exposed?  So 
instead of /path/to/foo/.gfs2_admin/metafile you'd prefer having a 
separate mount point like /proc/fs/gfs/path/to/foo/metafile?


Christoph Hellwig wrote:
>>  b) The .gfs2_admin directory exposes the internal files that GFS uses
>>     to store various bits of file system related information. This means
>>     that we've been able to remove virtually all the ioctl() calls from
>>     GFS2. There is one ioctl() call left which relates to
>>     getting/setting GFS2 specific flags on files. The various GFS2 tools
>>     will be updated in due course to use this new interface.
> 
> Without even looking at the code a strong NACK here.  This is polluting
> the namespace which is not acceptable.  Please implement a second
> filesystem type gfsmeta to do this kind of admin work.  Search for ext2meta
> which did something similar.  Or use a completely different approach,
> I'd need to look at the actual functionality provided to give a better
> advice, but currently I'm lacking the time for that.
> 

