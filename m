Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289344AbSAVSub>; Tue, 22 Jan 2002 13:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289346AbSAVSu1>; Tue, 22 Jan 2002 13:50:27 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:51205 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289344AbSAVSuM>; Tue, 22 Jan 2002 13:50:12 -0500
Message-ID: <3C4DB36F.4090306@namesys.com>
Date: Tue, 22 Jan 2002 21:46:07 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Chris Mason <mason@suse.com>, Andreas Dilger <adilger@turbolabs.com>,
        Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201221234470.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Tue, 22 Jan 2002, Chris Mason wrote:
>
>>It seems like the basic features we are suggesting are very close, I'll try
>>one last time to make a case against the 'free_some_pages' call ;-)
>>
>
>>The FS doesn't know how long a page has been dirty, or how often it
>>gets used,
>>
>
>In an efficient system, the FS will never get to know this, either.
>

I don't understand this statement.  If dereferencing a vfs op for every 
page aging is too expensive, then ask it to age more than one page at a 
time.  Or do I miss your meaning?

>
>
>The whole idea behind the VFS and the VM is that calls to the FS
>are avoided as much as possible, in order to keep the system fast.
>
In other words, you write the core of our filesystem for us, and we 
write the parts that don't interest you?

Maybe this is the real meat of the issue?

Hans



