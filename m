Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268589AbUIGTQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268589AbUIGTQI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268581AbUIGTQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:16:07 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:43984 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268503AbUIGTOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:14:40 -0400
Message-ID: <413E08A4.9020005@namesys.com>
Date: Tue, 07 Sep 2004 12:14:44 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Spam <spam@tnonline.net>, Christer Weinigel <christer@weinigel.se>,
       David Masover <ninja@slaphack.com>, Tonnerre <tonnerre@thundrix.ch>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200409071815.i87IFseF004907@laptop11.inf.utfsm.cl>
In-Reply-To: <200409071815.i87IFseF004907@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>Hans Reiser <reiser@namesys.com> said:
>  
>
>>Horst von Brand wrote:
>>    
>>
>>>Spam <spam@tnonline.net> said:
>>>      
>>>
>>>>Christer Weinigel <christer@weinigel.se> said:
>>>>        
>>>>
>
>[...]
>
>  
>
>>>>>2. How do we want to expose named streams?
>>>>>          
>>>>>
>
>  
>
>>>>>  One suggestion is file-as-directory in some form.
>>>>>          
>>>>>
>
>  
>
>>>Which is broken, as it forbids hard links to files.
>>>      
>>>
>
>  
>
>>No, it forbids hard links to the directory aspect of the file-directory 
>>duality.
>>    
>>
>
>How do you distinguish a "hard link to the directory personality" from
>"hard link to the file personality"?
>
Put in (undoubtedly overly) simple terms, if you can do it to a file you 
can do it to the file personality, but if you currently can only do it 
to a directory and get an error from attempting it to a file then in the 
new scheme doing it to the hard link only gives the same error.

Or, we can ask Alexander to help us use his deadlock detection algorithm 
and try to do things right....

