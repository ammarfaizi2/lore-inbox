Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262892AbTCKKei>; Tue, 11 Mar 2003 05:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262893AbTCKKei>; Tue, 11 Mar 2003 05:34:38 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:13494 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262892AbTCKKeh>; Tue, 11 Mar 2003 05:34:37 -0500
Message-ID: <3E6DBE3B.8030007@namesys.com>
Date: Tue, 11 Mar 2003 13:45:15 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger@clusterfs.com>,
       Christopher Li <chrisl@vmware.com>, Alex Tomas <bzzz@tmi.comex.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Improved inode number allocation for HTree
References: <11490000.1046367063@[10.10.2.4]> <20030310204146.875D3F0D4D@mx12.arcor-online.net> <3E6D1D25.5000004@namesys.com> <20030311031216.8A31CEFD5F@mx12.arcor-online.net>
In-Reply-To: <20030311031216.8A31CEFD5F@mx12.arcor-online.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let's make noatime the default for VFS.

Daniel Phillips wrote:

>Hi Hans,
>
>On Tue 11 Mar 03 00:17, Hans Reiser wrote:
>  
>
>>What do you think of creating a new telldir/seekdir which uses filenames
>>instead of ints to convey position?
>>    
>>
>
>What do you do if that file gets deleted in the middle of a traversal?
>
So what?  It still tells you where to restart.  Strictly speaking, you 
would want to allow the filesystem to choose what it wants to return to 
indicate position.  For htree and reiserfs this would be a filename or 
its hash, for ext2 without htree this would be a byte offset.

>
>If I were able to design Unix over again, I'd state that if you don't lock a 
>directory before traversing it then it's your own fault if somebody changes 
>it under you, and I would have provided an interface to inform you about your 
>bad luck.  Strictly wishful thinking.  (There, it feels better now.)
>
We are designing Linux.  You know, Microsoft and Steve Jobs continue to 
design.  We should too.

Needless change should be avoided.  Failure to change when something is 
known to be broken leads to being inferior to those who do change.

Let's design something that does it right.  Or else SCO will be right in 
saying that Linux is just a Unix ripoff by people who couldn't do 
anything unless Unix had been written to tell them how to do it right.

-- 
Hans


