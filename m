Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267598AbUH2Jl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267598AbUH2Jl4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 05:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267578AbUH2Jl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 05:41:56 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:39323 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267461AbUH2Jlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 05:41:51 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <4131A3B2.30203@namesys.com>
Date: Sun, 29 Aug 2004 02:36:50 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Helge Hafting <helgehaf@aitel.hist.no>, Rik van Riel <riel@redhat.com>,
       Spam <spam@tnonline.net>, Jamie Lokier <jamie@shareable.org>,
       David Masover <ninja@slaphack.com>, Diego Calleja <diegocg@teleline.es>,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       jra@samba.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no> <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org> <4131074D.7050209@namesys.com> <Pine.LNX.4.58.0408282159510.2295@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408282159510.2295@ppc970.osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Sat, 28 Aug 2004, Hans Reiser wrote:
>  
>
>>I object to openat().....
>>    
>>
>
>Sound slike you object to O_XATTRS, not openat() itself.
>
>Realize that openat() works independently of any special streams, it's
>fundamentally a "look up name starting from this file" (rather than
>"starting from root" or "starting from cwd").
>
>		Linus
>
>
>  
>
well, isn't that namespace fragmentation by definition?  If you can't go

cat filenameA/metas/permissions > filenameB/metas/permissions

find / -exec cat {}/permissions \; | grep 4777 | wc -l

then aren't you missing the whole point of this exercise which is to 
allow the whole OS to be better integrated into a more unified namespace 
so that data can leap from one tool to another, and one container to 
another, with the greatest of ease?  If cat cannot access the metadata 
without changing the code of cat, then all the elegance goes poof.

It completely baffles me what disabling filenameA/.. does for us.  Why 
add asymmetries?  Ease of implementation is no excuse for such asymmetry.

Tomorrow I am going to send a little essay I wrote this evening on these 
metafiles.
