Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUH1KKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUH1KKF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 06:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUH1KEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 06:04:05 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:15599 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266391AbUH1J64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:58:56 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <4130562B.5020709@namesys.com>
Date: Sat, 28 Aug 2004 02:53:47 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Rik van Riel <riel@redhat.com>, Spam <spam@tnonline.net>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just have a special name instead of a special boundary, or, better, have 
a filename/pseudos/backup method that outputs everything needed to 
backup the object "filename".

Hans

Linus Torvalds wrote:

>On Fri, 27 Aug 2004, Rik van Riel wrote:
>  
>
>>Thing is, there is no way to distinguish between what are
>>virtual files and what are actual streams hidden inside a
>>file.  You don't know what should and shouldn't be backed
>>up...
>>    
>>
>
>I think that lack of distinguishing poiwer is more serious for 
>directories. The more I think I think about it, the more I wonder whether 
>Solaris did things right - having a special operation to "cross the 
>boundary".
>
>I suspect Solaris did it that way because it's a hell of a lot easier to 
>do it like that, but regardless, it would solve the issue of real 
>directories having both real children _and_ the "extra streams".
>
>		Linus
>
>
>  
>

