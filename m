Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263256AbVGAHnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263256AbVGAHnB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263266AbVGAHnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:43:00 -0400
Received: from colo.tr0n.com ([66.207.132.11]:60600 "EHLO tr0n.com")
	by vger.kernel.org with ESMTP id S263256AbVGAHmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 03:42:53 -0400
Message-ID: <42C4F38C.9020000@nauticom.net>
Date: Fri, 01 Jul 2005 03:41:00 -0400
From: Chet Hosey <chosey@nauticom.net>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Kevin Bowen <kevin@ucsd.edu>, Hubert Chan <hubert@uhoreg.ca>,
       Hans Reiser <reiser@namesys.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       David Masover <ninja@slaphack.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200507010328.j613SV3h004647@laptop11.inf.utfsm.cl>
In-Reply-To: <200507010328.j613SV3h004647@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>Kevin Bowen <kevin@ucsd.edu> wrote:
>  
>
>>                                                            and think
>>about it just limited to a user's home directory, and the storage and
>>organization of actual *data* (as opposed to system files).
>>    
>>
>
>Who is to say what is "data" and what is "system files"? And if you are
>limiting yourself to /user/ data, why not have the /user/ decide how they
>want to organize it, and give them the tools?
>  
>
That's exactly what the idea of exporting the metadata as files within a
file-as-dir is intended to do: let the user decide how to manage
metadata. They have the tools -- anything which can interact with a
file. This includes users who never start X.

>  
>
>>                                                            The desire
>>amongst users for ubiquitous metadata is very real - the current wave of
>>"desktop search" products and technologies demonstrates this - 
>>    
>>
>
>Just like each previous claim "this /must/ be the next cool technology!",
>also called later the "dotcom crash"...
>  
>
How does that analogy hold? An example of a technology which is actually
in demand is similar to the tech bubble exactly how?

>>                                                               but
>>search is really only the lowest-hanging fruit of this new way of
>>looking at data. Application-layer solutions like Beagle,
>>    
>>
>
>That works without screwing up the whole system, AFAIU.
>
>  
>
If you define "works" as "implements a proprietary layer which can't be
used naturally by the same tools UNIX users have used for years to
manage data".

>And who says that a normal user isn't allowed to annotate each and every
>file with its purpose or something else? I can very well imagine a system
>in which users (say students in a Linux class) want to do so... on a shared
>machine. Or users having a shared MP3 or photograph or ... collection, with
>individual notes on each. Or even developers wanting to annotate source
>code files with their comments, but leave them read-only (or have them
>under SCM).
>
>  
>
This same argument could be used to attack the idea of group permissions
-- that groups of users might have conflicting goals. Implementing
metadata in userspace via bundled files has the same drawback.

>>                           If you're sysadmining a multiuser reiser4
>>box, and your users are able to modify the metadata of files they don't
>>own, then you go to sysadmin purgatory. 
>>    
>>
>
>Bingo! And thus goes much of the supposed advantage of this nonsense.
>
>  
>
You seem to be implying that on a Reiser4 filesystem used by multiple
users that people other than file owners will be about to apply
arbitrary metadata to any object. It seems to me that adding metadata to
a file-as-dir will require the same permissions as writing to the file
itself, giving Reiser4 *zero* disadvantage against other multiuser
systems. What gives you the impression that adding metadata to a
file-as-dir is any harder to secure against modification from other
users than the files themselves are in the first place?

>[I see that /opponents/ are accused here of lack of imagination, while I
> see that the /proponents/ lack imagination... or perhaps just real-world
> experience.]
>
>  
>
Huh? The idea of arbitrary metadata isn't just with annotating MP3
files. One seemingly important consideration would be the flexible
implementation of add-on mechanisms, like security data, that could be
implemented with zero changes to the filesystem. And you get to use
existing tools to deal with new and arbitrary interfaces instead of
having to deal with GUI garbage just to interact with metadata.

>>>other way; OpenOffice /has/ structured files, XML inside zipped files,
>>>Java also uses zip files for its structuring needs, etc), or are ideas
>>>that
>>>      
>>>
>
>  
>
>>And as a Java developer, I can tell you that the wide consensus is that
>>this solution is half-assed and insufficient for both developers and
>>users needs. In fact, I believe there is currently a JSR in progress to
>>develop a more sophisticated Java packaging model.
>>    
>>
>
>Presumably based on ReiserFS 4, which then has to be ported to whatever
>platform you want to run Java on ASAP? Great for you! Wait a bit, and
>you'll get what you want then, even across the board!
>  
>
Are unable to differentiate between a statement that a given solution is
non-ideal and a suggestion that everything be done in a way that
requires Reiser4? Someone mentions that the current solution isn't quite
meeting all of their needs, and you respond with rhetoric accusing them
of wanting everything to depend on Reiser4 and bloat the kernel. How is
this productive?

