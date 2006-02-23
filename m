Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751770AbWBWTqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbWBWTqq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWBWTqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:46:46 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:45989 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751767AbWBWTqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:46:45 -0500
Message-ID: <43FE1110.1030707@vilain.net>
Date: Fri, 24 Feb 2006 08:46:24 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Xin Zhao <uszhaoxin@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: question about possibility of data loss in Ext2/3 file system
References: <4ae3c140602221356x15015171h5aa4a3d7bb6034e0@mail.gmail.com> <1140645651.2979.79.camel@laptopd505.fenrus.org> <4ae3c140602221434v6ec583a7yf04df5fa7a4948fc@mail.gmail.com> <20060223045836.GC9645@thunk.org>
In-Reply-To: <20060223045836.GC9645@thunk.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
>>Also, the scheme you mentioned is just for new file creation. What
>>will happen if I want to update an existing file? Say, I open file A,
>>seek to offset 5000, write 4096 bytes, and then close. Do you know how
>>ext2/3 handle this situation?
> If you have a power failure right after the close, the data could be
> lost.  This is true for pretty much all Unix filesystems, for
> performance reasons.  If you care about the data hitting disk, the
> application must use fsync().  

I always liked Sun's approach to this in Online Disk Suite - journal at 
the block device level rather than the FS / application level. 
Something I haven't seen from the Linux md-utils or DM.

Sam.
