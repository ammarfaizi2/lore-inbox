Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267999AbUHZIsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267999AbUHZIsh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUHZIpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:45:07 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:55174 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267901AbUHZIlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:41:32 -0400
Message-ID: <412DA23C.7090702@namesys.com>
Date: Thu, 26 Aug 2004 01:41:32 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Nicholas Miell <nmiell@gmail.com>, Wichert Akkerman <wichert@wiggy.net>,
       Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
       Spam <spam@tnonline.net>, torvalds@osdl.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826010355.GB24731@mail.shareable.org>
In-Reply-To: <20040826010355.GB24731@mail.shareable.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

>Nicholas Miell wrote:
>  
>
>>Anything that currently stores a file's metadata in another file really
>>wants this right now. Things like image thumbnails, document summaries,
>>digital signatures, etc.
>>    
>>
>
>Additionally, all of those things you describe should be deleted if
>the file is modified -- to indicate that they're no longer valid and
>should be regenerated if needed.
>
>Whereas there are some other kinds of metadata which should not be
>deleted if the file is modified.
>
>-- Jamie
>
>
>  
>
Yes, I agree.

Actually we plan to have a whole link taxonomy, and one expected feature 
is that some links don't count towards the refcount needed to keep an 
object in existence (For instance, the links between key words and text 
documents, you don't want to have to explicitly unlink every keyword in 
order to delete a document).
