Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUIIQsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUIIQsn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUIIQnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:43:47 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:36105 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266310AbUIIQlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:41:37 -0400
Message-ID: <414088EE.9060703@techsource.com>
Date: Thu, 09 Sep 2004 12:46:38 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Wichert Akkerman <wichert@wiggy.net>
CC: Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1939276887.20040826114028@tnonline.net> <20040826024956.08b66b46.akpm@osdl.org> <839984491.20040826122025@tnonline.net> <20040826032457.21377e94.akpm@osdl.org> <742303812.20040826125114@tnonline.net> <20040826035500.00b5df56.akpm@osdl.org> <1453776111.20040826131547@tnonline.net> <20040826042043.15978b0a.akpm@osdl.org> <20040826112938.GK2612@wiggy.net>
In-Reply-To: <20040826112938.GK2612@wiggy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Wichert Akkerman wrote:
> Previously Andrew Morton wrote:
> 
>>But I'll grant that one cannot go adding new metadata to, say, C files this
>>way.  I don't know how useful such a thing is though.
> 
> 
> That is actually one of the few places where a bit of metadata would be
> very useful. Right now there is no way to indicate in what encoding a
> source is written: ascii, utf-8, ucs16, etc. are all possible. But a
> compiler or interpreter has no good way to figure that out.
> 


[NOTE:  I am 5000 messages behind.  Please forgive any redundancy.]

This reminds me of a paper someone wrote on how HFS(+) stored the file 
type (actually, application that knows how to use the file) as metadata, 
separate from the filename.  He was lamenting the fact that the Mac was 
being 'corrupted' by the PC's broken philosophy of including as part of 
the filename something which should not be.  He also mentioned that 
Windows' feature of hiding the extension doesn't cut it.  One benefit, I 
recall, was that you can't change the association accidentally when 
changing the filename.  Another thing was that file name and file type 
are not semantically related, so they shouldn't be squished together.

I don't remember this well enough, so I can't argue the point, but 
having the file type as metadata separate from the filename has SOME 
amount of elegant appeal to me.

