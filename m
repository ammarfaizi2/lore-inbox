Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265075AbTIDP7y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265078AbTIDP7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:59:54 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:20398 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265075AbTIDP7v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:59:51 -0400
Message-ID: <3F576176.3010202@namesys.com>
Date: Thu, 04 Sep 2003 19:59:50 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: precise characterization of ext3 atomicity
References: <3F574A49.7040900@namesys.com> <20030904085537.78c251b3.akpm@osdl.org>
In-Reply-To: <20030904085537.78c251b3.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser <reiser@namesys.com> wrote:
>  
>
>>Is it correct to say of ext3 that it guarantees and only guarantees 
>>atomicity of writes that do not cross page boundaries?
>>    
>>
>
>Yes.
>
>  
>
>>    By contrast, ext3 only guarantees the atomicity of a single write 
>>that does not span a page boundary, and it guarantees that its internal 
>>metadata will not be corrupted even if your applications data is 
>>corrupted after the crash.
>>    
>>
>
>Not sure that I understand this.  In data=writeback mode, metadata
>integrity is preserved but data writes may be lost.  In data=journal and
>data=ordered modes the data and the metadata which refers to it are always
>in sync on-disk.
>
>
>
>  
>
Perhaps the following is correct?

    By contrast, ext3 in data=journal and data=ordered modes only guarantees the atomicity of a single write 
that does not span a page boundary, and it guarantees that its internal 
metadata will not be corrupted even if your application's data is 
corrupted after the crash (due to the application spreading what should be committed atomically across more than one block).





-- 
Hans


