Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316869AbSFKHHp>; Tue, 11 Jun 2002 03:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316877AbSFKHHo>; Tue, 11 Jun 2002 03:07:44 -0400
Received: from rj.SGI.COM ([192.82.208.96]:28107 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S316869AbSFKHHo>;
	Tue, 11 Jun 2002 03:07:44 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files 
In-Reply-To: Your message of "Mon, 10 Jun 2002 23:49:02 MST."
             <3D059D5E.C9F9F659@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Jun 2002 17:07:37 +1000
Message-ID: <11378.1023779257@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002 23:49:02 -0700, 
Andrew Morton <akpm@zip.com.au> wrote:
>Keith Owens wrote:
>> On Mon, 10 Jun 2002 23:17:27 -0700,
>> Andrew Morton <akpm@zip.com.au> wrote:
>> >     The st_ctime and st_mtime fields of a file that is mapped with MAP_SHARED
>> >     and PROT_WRITE shall be marked for update at some point in the interval
>> >     between a write reference to the mapped region and the next call to msync() with
>> >     MS_ASYNC or MS_SYNC for that portion of the file by any process. If there is
>> >     no such call and if the underlying file is modified as a result of a write reference,
>> >     then these fields shall be marked for update at some time after the write reference.
>> 
>> That says nothing about a file where the only updates are via mmap.  My
>> file had grown to its final size so there were no more writes, only
>> pages being dirtied via mmap.
>
>It is specifically referring to updates via mmap!  "a write reference
>to the mapped region".  This is the mmap documentation.

I saw "write reference" and my brain translated that to "write()".  I
blame the long weekend.

