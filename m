Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281916AbSAUBFp>; Sun, 20 Jan 2002 20:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288327AbSAUBFd>; Sun, 20 Jan 2002 20:05:33 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:64271 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S285692AbSAUBFS>; Sun, 20 Jan 2002 20:05:18 -0500
Message-ID: <3C4B6867.8070302@namesys.com>
Date: Mon, 21 Jan 2002 04:01:27 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201202242240.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Mon, 21 Jan 2002, Hans Reiser wrote:
>
>>Suppose we do what you ask, and always write the page (as well as some
>>other pages) to disk.  This will result in the filesystem cache as a
>>whole receiving more pressure than other caches that only write one
>>page in response to pressure.  This is unbalanced, leads to some
>>caches having shorter average page lifetimes than others, and it is
>>therefor suboptimal.  Yes?
>>
>
>If your ->writepage() writes pages to disk it just means
>that reiserfs will be able to clean its pages faster than
>the other filesystems.
>
the logical extreme of this is that no write caching should be done at 
all, only read caching?

>
>
>This means the VM will not call reiserfs ->writepage() as
>often as for the other filesystems, since more of the
>pages it finds will already be clean and freeable.
>
>I guess the only way to unbalance the caches is by actually
>freeing pages in ->writepage, but I don't see any real reason
>why you'd want to do that...
>
>regards,
>
>Rik
>
It would unbalance the write cache, not the read cache.

Hans

