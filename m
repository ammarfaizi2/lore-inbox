Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVBVTB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVBVTB0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVBVS7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 13:59:38 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:30101 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261326AbVBVS70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 13:59:26 -0500
Message-ID: <421B8203.9080308@sgi.com>
Date: Tue, 22 Feb 2005 13:03:31 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Paul Jackson <pj@sgi.com>, mingo@elte.hu, mort@wildopensource.com,
       linux-kernel@vger.kernel.org, hilgeman@sgi.com
Subject: Re: [PATCH/RFC] A method for clearing out page cache
References: <20050214154431.GS26705@localhost>	<20050214193704.00d47c9f.pj@sgi.com>	<20050221192721.GB26705@localhost>	<20050221134220.2f5911c9.akpm@osdl.org>	<421A607B.4050606@sgi.com>	<20050221144108.40eba4d9.akpm@osdl.org>	<20050222075304.GA778@elte.hu>	<20050222032633.5cb38abb.pj@sgi.com> <20050222104535.0b3a3c65.akpm@osdl.org>
In-Reply-To: <20050222104535.0b3a3c65.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Paul Jackson <pj@sgi.com> wrote:
> 
>> As Martin wrote, when he submitted this patch:
>> > The motivation for this patch is for setting up High Performance
>> > Computing jobs, where initial memory placement is very important to
>> > overall performance.
>>
>> Any left over cache is wrong, for this situation.
> 
> 
> So...  Cannot the applicaiton remove all its pagecache with posix_fadvise()
> prior to exitting?
> 

Even if we modified all applications to do this, it still wouldn't help for
dirty page cache, which would eventually become cleaned, and hang around long
after the application has departed.

But the previous statement has a false hypothesis, namely, that we could
change all applications to do this.

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
