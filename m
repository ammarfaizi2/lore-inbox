Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288851AbSAUBMm>; Sun, 20 Jan 2002 20:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288921AbSAUBMd>; Sun, 20 Jan 2002 20:12:33 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:12816 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288851AbSAUBMX>; Sun, 20 Jan 2002 20:12:23 -0500
Message-ID: <3C4B6A0D.5000006@namesys.com>
Date: Mon, 21 Jan 2002 04:08:29 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201202252070.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Mon, 21 Jan 2002, Hans Reiser wrote:
>
>>Not if you provide a proper design of a master cache manager.
>>Really, all you have to do is have the subcache managers designed to
>>free the same number of pages on average in response to pressure, and
>>to pressure them in proportion to their size, and it is pretty simple
>>for VM.
>>
>
>I take it you're volunteering to bring ext3, XFS, JFS,
>JFFS2, NFS, the inode & dentry cache and smbfs into
>shape so reiserfs won't get unbalanced ?
>
>regards,
>
>Rik
>
If they use writepage(), then the job of balancing cache cleaning is 
done, we just use
writepage as their pressuring mechanism.  Any FS that wants to optimize 
cleaning
can implement a VFS method, and any FS that wants to optimize freeing 
can implement a VFS method,
and all others can use their generic VM current mechanisms.

Hans

