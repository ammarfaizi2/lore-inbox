Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265138AbSJPQN4>; Wed, 16 Oct 2002 12:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265147AbSJPQNz>; Wed, 16 Oct 2002 12:13:55 -0400
Received: from packet.digeo.com ([12.110.80.53]:11392 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265138AbSJPQNz>;
	Wed, 16 Oct 2002 12:13:55 -0400
Message-ID: <3DAD917E.B62ABDDA@digeo.com>
Date: Wed, 16 Oct 2002 09:19:10 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: riel@surriel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] do_generic_file_read / readahead adjustments
References: <30738.1034782153@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2002 16:19:10.0589 (UTC) FILETIME=[C270F2D0:01C2752F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> 
> The attached patch does the following three things:
> 
>  (1) Makes the functions in mm/readahead.c only use struct file* to pass to
>      readpage(). address_mapping* and file_ra_state* are used instead to keep
>      track of readahead stuff.
> 
>  (2) Adds a new function do_generic_mapping_read() that is similar to
>      do_generic_file_read(), except that it uses a mapping pointer and a
>      readahead state pointer to access a file. The file* is only used to pass
>      to readpage().
> 
>  (3) Turns do_generic_file_read() into an inline function in linux/fs.h that
>      simply wraps do_generic_mapping_read().
> 

Seems sensible.  Is there something out there which actually uses this?
