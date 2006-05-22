Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWEVIT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWEVIT6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 04:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWEVIT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 04:19:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29141 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750788AbWEVIT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 04:19:57 -0400
Message-ID: <4471741A.1000804@themaw.net>
Date: Mon, 22 May 2006 16:19:38 +0800
From: Ian Kent <raven@themaw.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: Andrew Morton <akpm@osdl.org>, Badari Pulavarty <pbadari@us.ibm.com>,
       bcrl@kvack.org, cel@citi.umich.edu, zach.brown@oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Remove readv/writev methods and use aio_read/aio_write
 instead
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com> <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com> <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com> <1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com> <1147728133.6181.2.camel@dyn9047017100.beaverton.ibm.com> <20060521180037.3c8f2847.akpm@osdl.org> <20060522053450.GA22210@lst.de>
In-Reply-To: <20060522053450.GA22210@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sun, May 21, 2006 at 06:00:37PM -0700, Andrew Morton wrote:
>> Badari Pulavarty <pbadari@us.ibm.com> wrote:
>>> This patch removes readv() and writev() methods and replaces
>>>  them with aio_read()/aio_write() methods.
>> And it breaks autofs4
>>
>> autofs: pipe file descriptor does not contain proper ops
> 
> this comes because the autofs4 pipe fd doesn't have a write file
> operations.
> 
> Badari do you remember any place in your patches where you didn't
> add do_sync_write for a file_operations instance?
> 
> Ian, what kind of file is the autofs4 pipe?  is it a named pipe or
> a fifo or a "real" file?

Ahh. Sorry missed the actual question.
It's a FIFO created with pipe(2).

