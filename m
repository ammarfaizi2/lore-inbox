Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269611AbUHZUxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269611AbUHZUxv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269640AbUHZUuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:50:54 -0400
Received: from mx3.sover.net ([209.198.87.173]:39119 "EHLO mx3.sover.net")
	by vger.kernel.org with ESMTP id S269556AbUHZUjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:39:16 -0400
Message-ID: <412E4999.1050504@sover.net>
Date: Thu, 26 Aug 2004 16:35:37 -0400
From: Stephen Wille Padnos <spadnos@sover.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Thu, 26 Aug 2004, Linus Torvalds wrote:
>  
>
>>So "/tmp/bash" is _not_ two different things. It is _one_ entity, that
>>contains both a standard data stream (the "file" part) _and_ pointers to
>>other named streams (the "directory" part).
>>    
>>
>Thinking about it some more, how would file managers and
>file chosers handle this situation ?
>
>Currently the user browses the directory tree and when
>the user clicks on something, one of the following 
>happens:
>
>1) if it is a directory, the file manager/choser changes
>   into that directory
>  
>
How does the file manager / chooser decide whether you're trying to move 
into a directory, or the meta-data-directory for a directory?
It's not just files that should have metadata - directories need* them 
too.  Making it possible to see attributes as a directory under a file 
is great, but you'd still need an O_META flag for accessing directory 
metadata (since there are already files under a directory).

>2) if it is a file, the file is opened
>
>Now how do we present things to users ?
>
>How will users know when an object can only be chdired
>into, or only be opened ?
>
>For objects that do both, how does the user choose ?
>
>Do we really want to have a file paradigm that's different
>from the other OSes out there ?
>  
>
MacOS does, Be did (sort of).  I'm not sure it would be the end of the 
world, as long as the data can be extracted.

>What happens when users want to transfer data from Linux
>to another system ?
>  
>
That would depend on the other system.  Data is easy, metadata is hard.
It would be possible to create an XML schema for metadata, and if 
requested (O_EVERYTHING?), the file data is returned with all metadata 
in XML tags.  (not advocating this, just an idea :)
- Steve

* I say need in the same way as one *needs* to upgrade their 2GHz 
computer - it would be nice :)

