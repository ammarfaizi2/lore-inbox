Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUH0Koy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUH0Koy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 06:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUH0Koy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 06:44:54 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:52956 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262062AbUH0Kou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 06:44:50 -0400
Message-ID: <412F00AA.9000402@dgreaves.com>
Date: Fri, 27 Aug 2004 10:36:42 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Rik van Riel <riel@redhat.com>,
       Diego Calleja <diegocg@teleline.es>, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com><Pine.LNX.4.58.0408261101110.2304@ppc970.osdl.org> <45010000.1093553046@flay> <Pine.LNX.4.58.0408261348500.2304@ppc970.osdl.org> <57730000.1093554054@flay> <Pine.LNX.4.58.0408261402400.2304@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408261402400.2304@ppc970.osdl.org>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Thu, 26 Aug 2004, Martin J. Bligh wrote:
>  
>
>>I think what you're saying is that they'd both return positive, right?
>>    
>>
>
>No. I'd say that a file would look like a file, even if it has attributes.
>
>It wouldn't show as a directory at all - unless you start looking at 
>attributes. Because it really _is_ a file, and it's "directory aspect" is 
>really nothing but a way to make its named streams visible.
>
>So you really should consider it a perfectly regular file, and so only 
>S_ISREG() will return true, and S_ISDIR() will return false.
>
>  
>
ie, logically:

S_ISREG() no longer precludes O_DIRECTORY from succeeding
conversley
O_DIRECTORY succeeding no longer implies S_ISDIR()

However, apps making those assumptions will not notice new behaviour.

?

David

