Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUIIRhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUIIRhb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUIIRhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:37:02 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:52127 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266457AbUIIRaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:30:24 -0400
Message-ID: <41408F61.503@yahoo.com.au>
Date: Fri, 10 Sep 2004 03:14:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Andrey Savochkin <saw@saw.sw.com.sg>, linux-kernel@vger.kernel.org
Subject: Re: Q about pagecache data never written to disk
References: <20040905120147.A9202@castle.nmd.msu.ru> <20040905035233.6a6b5823.akpm@osdl.org> <20040905154336.B9202@castle.nmd.msu.ru> <20040905140040.58a5fcdc.akpm@osdl.org> <20040909123957.GB1065@elf.ucw.cz> <41405773.3090403@yahoo.com.au> <20040909133703.GA32038@atrey.karlin.mff.cuni.cz> <41405B51.20705@yahoo.com.au> <20040909172433.GA3106@holomorphy.com>
In-Reply-To: <20040909172433.GA3106@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Thu, Sep 09, 2004 at 11:32:01PM +1000, Nick Piggin wrote:
> 
>>writeback isn't, but the pages will get marked dirty at unmap.
>>But I think I am wrong actually - I don't actually see why the
>>user would have to have the file open.
> 
> 
> Dirty memory "limits" have no force as applied to mmap() IO, which is
> not a pretty state of affairs with respect to various attempts the VM
> makes at mitigating data structure proliferation associated with dirty
> data.
> 

Yeah I know. data structure proliferation and just the simple fact
that it can't immediately be freed is a problem.

What is the alternative? Take a fault every time we write to a clean,
mmapped page?
