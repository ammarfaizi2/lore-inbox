Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268533AbUIGTzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268533AbUIGTzH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268539AbUIGTyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:54:32 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:36849 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268553AbUIGTbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:31:23 -0400
Message-ID: <413E0C88.6020402@namesys.com>
Date: Tue, 07 Sep 2004 12:31:20 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org, Alexander Zarochentcev <zam@namesys.com>,
       vs <vs@thebsh.namesys.com>, Edward Shishkin <edward@namesys.com>
Subject: Re: [PATCH - EXPERIMENTAL] files with forks in the VFS
References: <16699.44411.361938.856856@cse.unsw.edu.au>	<413BFCB5.4010608@namesys.com> <16700.60673.453455.255327@cse.unsw.edu.au>
In-Reply-To: <16700.60673.453455.255327@cse.unsw.edu.au>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

>On Sunday September 5, reiser@namesys.com wrote:
>  
>
>>Neil Brown wrote:
>>
>>    
>>
>>>As a followup to the multi-branching threads about reiser4, I would
>>>like to present this patch for discussion and exploration.
>>>It implements files with fork (which are quite different to files that
>>>provide different views via a subdirectory structure).
>>> 
>>>
>>>      
>>>
>>How are they different?  Having a distinguished file is consistent with 
>>the reiser4 approach.
>>
>>    
>>
>
>They are different at least in my perception.  It is possible that a
>common abstraction and a common implementation could support them
>both, though I am slightly sceptical.
>
>On the one hand, you have a name space within a file which provides
>access to information that is not part of that file but is only
>loosely associated with it:  an icon for a desktop app, documentation
>for a program, a collection of fonts that a document uses.
>
>On the other hand, you have a name space within a file which provides
>alternate views onto information that already exists within that
>file:  "unzip" which presents the file uncompressed, "tar" which
>explodes a tar achieve, "tag" which shows tags in a multi-media
>file. "elf" which exposes sections of an ELF executable.
>
>In the first case, the subordinate files should clearly be writable,
>and should be backed up along with the main file.
>In the second case, it is not clear that subordinate files should or
>could be writable in general (though there may well be specific
>cases), and the data does not need to be backed up.
>  
>
After the file compression plugin we should consider creating a 
directory compression plugin for directories with lots of small files....

>In the first case, the extra semantic only applies to files, not
>directories (allowing a directory to have extra streams is nothing
>new).
>In the second case, the extra semantic should apply to directories as
>well (as there may we be different views you might want on a
>directory). 
>  
>
I don't understand the paragraph above.  Can you say with fewer 
indirections (e.g. define extra semantic)?

>NeilBrown
>
>
>  
>

