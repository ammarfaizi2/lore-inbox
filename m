Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269835AbUH0AD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269835AbUH0AD6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269817AbUH0AAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:00:49 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:56499 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269802AbUHZXyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:54:13 -0400
Message-ID: <412E7821.7020100@namesys.com>
Date: Thu, 26 Aug 2004 16:54:09 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>, wichert@wiggy.net,
       jra@samba.org, torvalds@osdl.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408260935130.26316-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408260935130.26316-100000@chimarrao.boston.redhat.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Thu, 26 Aug 2004, Andrew Morton wrote:
>
>  
>
>>All of which can be handled in userspace library code.
>>
>>What compelling reason is there for doing this in the kernel?
>>    
>>
>
>There's a compelling reason to do it in userspace.  If an
>unaware program copies or moves such a file with streams
>inside, it doesn't break the streams and aware programs will
>continue to see them.
>
>OTOH, if we had the streams in the kernel, unaware applications
>would continuously break the metadata and streams that the
>streams aware programs expect !
>
>  
>
Well, first off, you don't want streams in the kernel, you want all the 
little pieces that can be composed together into a stream if you so 
choose.  Streams are ugly, the pieces are all cool.
