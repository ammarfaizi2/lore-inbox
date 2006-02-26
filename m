Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWBZV1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWBZV1U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWBZV1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:27:20 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:28071 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1750940AbWBZV1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:27:19 -0500
Message-ID: <44021D2D.20105@vilain.net>
Date: Mon, 27 Feb 2006 10:27:09 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Xin Zhao <uszhaoxin@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: question about possibility of data loss in Ext2/3 file system
References: <4ae3c140602221356x15015171h5aa4a3d7bb6034e0@mail.gmail.com> <1140645651.2979.79.camel@laptopd505.fenrus.org> <4ae3c140602221434v6ec583a7yf04df5fa7a4948fc@mail.gmail.com> <20060223045836.GC9645@thunk.org> <43FE1110.1030707@vilain.net> <20060224162957.GA22097@thunk.org>
In-Reply-To: <20060224162957.GA22097@thunk.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
>>I always liked Sun's approach to this in Online Disk Suite - journal at 
>>the block device level rather than the FS / application level. 
>>Something I haven't seen from the Linux md-utils or DM.
> You can do data block journalling in ext3.  But the performance impact
> can be significant for some work loads.   TNSFAAFL.

Sure, but on a large system with a big array, you just move the journal 
to a seperate diskset.  That can make a big speed improvement for those 
types of update patterns where you care about always applying updates 
sequentially, such as a filesystem or a database.

Sam.
