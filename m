Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267650AbUIFNVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267650AbUIFNVk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 09:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268011AbUIFNVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 09:21:36 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:20484 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267650AbUIFNV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 09:21:26 -0400
Message-ID: <413C6561.2030408@hist.no>
Date: Mon, 06 Sep 2004 15:25:53 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Oliver Hunt <oliverhunt@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <200409031741.i83HfASY017164@laptop11.inf.utfsm.cl>
In-Reply-To: <200409031741.i83HfASY017164@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>Helge Hafting <helge.hafting@hist.no> said:
>
>[...]
>
>  
>
>>The only new thing needed is the ability for something to be both
>>file and directory at the same time.
>>    
>>
>
>Then why have files and directories in the first place?
>
>  
>
>>                                      Some tools will need
>>a update - usually only because they blindly assume that a directory
>>isn't a file too, or that a file can't be a directory too.  Remove the
>>mistaken assumption and things will work because the underlying system
>>calls (chdir or open) _will_ work.
>>    
>>
>
>But with some weird restrictions: No moving stuff around between files, no
>  
>
I see no need for such a weird restriction.  If it is "weird", why have it?
If someone want to move stuff from one subdirectory to another, let them.
I see no need to stop that just because a file-as-directory was involved.

>linking, some "files" can't be deleted (how would you handle removing the
>  
>
linking is a problem of course.  We can't have hardlinks to directories,
so no hardlinks to file-as-dir either unless the general problems with
directory links are solved.

>principal stream of a file?). 
>
A design decision.  Removing the principal stream may delete
the entire tree.  Or it may delete the principal stream only,
turning that file-as-dir back into a plain directory.

>Some stuff you'd love to do (is, in fact, the
>reason for this all) just can't be allowed (i.e., J. Random Luser setting
>his own icon for system-wide emacs). So the tools/scripts/users/sysadmins
>will have to be painfully aware that some of the files aren't, and some of
>the directories aren't either. Major pain in the neck to use, if you look
>closer.  Add extra kernel complexity. For little (if any) gain.
>  
>
The gain is indeed the interesting question here.  It isn't something
I desperately need.  But if file-as-directory _happens_, then I hope
it'll happen in a good way.  No unnecessary complications or restrictions,
and allowing existing stuff to work as well as possible.  There will 
surely be some
tool problems - but we certainly don't need to break every existing
tool the way a new form of "open" will. . .

Helge Hafting
