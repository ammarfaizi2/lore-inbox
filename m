Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279105AbRLLMFH>; Wed, 12 Dec 2001 07:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279307AbRLLME6>; Wed, 12 Dec 2001 07:04:58 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:2052 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S279105AbRLLMEr>; Wed, 12 Dec 2001 07:04:47 -0500
Message-ID: <3C17474B.3070207@namesys.com>
Date: Wed, 12 Dec 2001 15:02:19 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
CC: Nathan Scott <nathans@sgi.com>, Andreas Gruenbacher <ag@bestbits.at>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributes  interface)
In-Reply-To: <Pine.SOL.3.96.1011212015827.2712B-100000@draco.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:

>On Wed, 12 Dec 2001, Hans Reiser wrote:
>
>>Anton Altaparmakov wrote:
>>
>>>I was just stating a fact of how they are stored on NTFS, again something
>>>I have no power to change.
>>>
>>But does NTFS specificism/cripplism belong in VFS?
>>
>
>No, of course not. But the vfs needs to be able to cope with limitations
>of specific file systems (even if it is only by passing -Exyz into
>userspace).
>
We agree on this, I have no opposition to NTFS checking  size of files 
used to store EAs and rejecting any write more than 64k

>
>
>>>>Well, gosh, okay, maybe you want to prepend ',,' to streams and '..' to 
>>>>extended attributes.  I personally think Linux would only want to do so 
>>>>when used as a fileserver emulating NTFS/SAMBA.  There is no enhancement 
>>>>of user functionality from doing it for general purpose filesystems. 
>>>>
>>>Just wait until this functionality is available and watch all GUI things
>>>start to use it en masse! I don't doubt that GNOME/KDE/replace with your
>>>favourite window manager are going to hesitate to start putting in the
>>>icon, the name, and whatnot inside EAs or inside named streams the instant
>>>they are ubiquitously available and I think that makes a lot of sense too.
>>>No doubt I will get flamed for saying this but all flames go to
>>>/dev/null...
>>>
>>>Both MacOS and as of recently Windows do this kind of stuff, too, and it
>>>can't be long before Linux goes the same way, provided file systems
>>>support the required features (i.e. EAs and/or named streams) so I
>>>disagree with you this is only a compatibility thing. It might start out
>>>as one but it will find real world applications very quickly...
>>>
>>I am not saying that the features of EAs are not useful, I am saying 
>>that I want to choose them individually for particular files.
>>
>>It could be so much better to have EDIBLE_PIZZA (example from previous 
>>email) instead of just PIZZA, sigh.
>>
>
>I am not quite sure what you mean. Surely you can just have all features
>available at all times/to all files and then you just use the ones you
>want, just ignoring/not using the rest. Why do you see the need for
>"selecting features of EAs individually for particular files"? It makes
>sense when buying EDIBLE_PIZZA but I don't see how that can be transferred
>onto files. After all I can just have all pizza ingredients and only put
>the ones I want on the pizza just ignoring the others.
>
Inheriting stat data from the parent directory should be a feature 
available not just for streams, but for all files that want it. 
 Efficient small file access to a 32 byte file should be a feature 
available to all files, not just EAs.  Not being listed in readdir 
should be a feature available to all files, not just EAs.  Constraining 
what is written to them should be a feature available to all files, not 
just EAs, and arbitrary plugin based constraints should be possible.

Is this more clear?

Hans



