Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbVGFSJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVGFSJz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 14:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVGFSHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 14:07:38 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:7184 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262209AbVGFN0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 09:26:02 -0400
Message-ID: <42CBDBF4.30801@slaphack.com>
Date: Wed, 06 Jul 2005 08:26:12 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Hubert Chan <hubert@uhoreg.ca>, Chet Hosey <chosey@nauticom.net>,
       Kevin Bowen <kevin@ucsd.edu>, Hans Reiser <reiser@namesys.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200507060251.j662p7OC005227@laptop11.inf.utfsm.cl>
In-Reply-To: <200507060251.j662p7OC005227@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Hubert Chan <hubert@uhoreg.ca> wrote:
> 
>>On Fri, 01 Jul 2005 03:41:00 -0400, Chet Hosey <chosey@nauticom.net> said:
>>
>>>Horst von Brand wrote:
>>>
>>>>And who says that a normal user isn't allowed to annotate each and
>>>>every file with its purpose or something else?
> 
> 
>>Explain how you currently allow users to annotate arbitrary files.
> 
> 
> By keeping annotations /outside/ the files.
> 
> [...]
> 
> 
>>The situation is even better with file-as-dir.  If the administrator
>>wants to allow users to edit the description metadata for the file foo,
>>the administrator can set the appropriate permissions for
>>foo/.../description, and keep foo read-only.
> 
> 
> So now root is responsible in exquisite detail for random other users being
> able to keep info about my files?

If it's the general info that's associated with the file, and may even 
be stored inside the file, then yes, that's fair.

Although I could certainly imagine foo/.../descriptions being a 
directory that's world-writable, allowing each user to maintain their 
own file inside of it.  You can even set these per-user descriptions to 
be stored somewhere else, like the user's home directory, and that could 
work for CDs.

>>Actually, you could use something like unionfs to allow users to keep
>>their own annotations without affecting everyone else's.
> 
> 
> Again, root has to mount that stuff for each and every user?

Why is that a problem?  Put it in a script.  Mount each user's unionfs 
at boot.

And it's "something like unionfs" -- maybe it's a feature of metafs or 
reiserfs that we haven't thought of yet.  It certainly can't be unionfs 
as it stands, as unionfs doesn't work on top of any reiser.
