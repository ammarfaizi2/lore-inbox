Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290598AbSA3VKs>; Wed, 30 Jan 2002 16:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290603AbSA3VKj>; Wed, 30 Jan 2002 16:10:39 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:25003 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290598AbSA3VKV>; Wed, 30 Jan 2002 16:10:21 -0500
Message-ID: <3C586135.2020304@us.ibm.com>
Date: Wed, 30 Jan 2002 13:10:13 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Alex Khripin <akhripin@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: BKL in tty code?
In-Reply-To: <20020130184950.GA22442@morgoth.mit.edu> <1012418760.3219.43.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

>On Wed, 2002-01-30 at 13:49, Alex Khripin wrote:
>
>>I'm very much a newbie, and I'm wondering about the big kernel locks
>>in tty_io.c. What exactly are the locks in the read and write for? Is the
>>tty device that contested? Couldn't a finer grained lock be used?
>>
>There is probably some cleanup that is possible, but really getting the
>thing in gear (which means no BKL, which is probably the hardest part to
>rip out) require some level of rewrite.
>
People working on BKL removal tend to ignore these types of things (I 
know I do).  We concentrate on scalability and performance and the tty 
code isn't exactly a high point of lock contention.


