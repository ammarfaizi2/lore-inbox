Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268468AbUH3TDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268468AbUH3TDv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268258AbUH3TA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:00:59 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:9434 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268754AbUH3S46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:56:58 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <41337744.1070003@namesys.com>
Date: Mon, 30 Aug 2004 11:51:48 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Zarochentsev <zam@namesys.com>
CC: Jamie Lokier <jamie@shareable.org>, Rik van Riel <riel@redhat.com>,
       Christophe Saout <christophe@saout.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040826154446.GG5733@mail.shareable.org> <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com> <20040826165351.GM5733@mail.shareable.org> <20040830173757.GU5108@backtop.namesys.com>
In-Reply-To: <20040830173757.GU5108@backtop.namesys.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Zarochentsev wrote:

>On Thu, Aug 26, 2004 at 05:53:51PM +0100, Jamie Lokier wrote:
>  
>
>>Rik van Riel wrote:
>>    
>>
>>>And if an unaware application reads the compound file
>>>and then writes it out again, does the filesystem
>>>interpret the contents and create the other streams ?
>>>      
>>>
>>Yes, exactly that.  The streams are created on demand of course, and
>>by userspace helpers when that's appropriate which I suspect it almost
>>always is.
>>
>>    
>>
>>>Unless I overlook something (please tell me what), the
>>>scheme just proposed requires filesystems to look at
>>>the content of files that is being written out, in
>>>order to make the streams work.
>>>      
>>>
>>Yes.  Hence the idea of coherent views between two files: writing to
>>one affects the content of the other, although the calcalation is only
>>done on demand (or when the fs wants to migrate the representation --
>>for example, creating the flat container prior to deleting the
>>regeneratable pieces in order to save space).
>>
>>I haven't seen anything from Namesys that says they'll do that.
>>
We do that, err, it is our design to do that. Hmm, the plugins to do 
that seem to all be in the next to implement list and not on the 
implemented already list.....

However, with respect to streams, those are just files in a 
file-directory object in our scheme. If you want them unified, well, 
then you cat compound-document/pseudos/glued, or you link 
compound-document/pseudos/glued to compound-document/pseudos/body, where 
body is our term for the default stream, and then you just cat 
compound-document

If you have the impression I am being vaporwarish, well, you are 
right.... glued is not yet on the already implemented list.

Hans
