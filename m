Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbULQSKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbULQSKB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 13:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbULQSKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 13:10:01 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:18861 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262109AbULQSJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 13:09:48 -0500
Message-ID: <41C320EB.1050400@namesys.com>
Date: Fri, 17 Dec 2004 10:09:47 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
CC: David Masover <ninja@slaphack.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>	 <41ACA7C9.1070001@namesys.com>	 <1103043518.21728.159.camel@pear.st-and.ac.uk>	 <41BF21BC.1020809@namesys.com>	 <1103059622.2999.17.camel@grape.st-and.ac.uk>	 <41BFC1C5.1070302@slaphack.com>	 <1103102854.30601.12.camel@pear.st-and.ac.uk>	 <41C0CF3B.1030705@slaphack.com>  <41C1D870.2020407@namesys.com> <1103223664.2336.335.camel@pear.st-and.ac.uk>
In-Reply-To: <1103223664.2336.335.camel@pear.st-and.ac.uk>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Foldiak wrote:

>On Thu, 2004-12-16 at 18:48, Hans Reiser wrote:
>  
>
>>David Masover wrote:
>>    
>>
>>>Speaking of which, how much speed is lost by starting up a process?
>>>
>>>The idea of caching is that running
>>>
>>>cat *; cat *; cat *; cat *; cat *
>>>
>>>is probably slower than
>>>
>>>cat * > baz; cat baz; cat baz; cat baz; cat baz; cat baz
>>>      
>>>
>>Only for small files where the per file overhead of a read is significant.
>>    
>>
>
>But if the glued "file" is a stream (or pipe?) you can't do everything
>with it (e.g. seek() ) that you could do with a proper file, right?
>  
>
It does not need to be a pipe-like file.  Seek can be implemented for a 
composite (glued) file.

>You may want to do everything with it that you can do with a proper
>file.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

