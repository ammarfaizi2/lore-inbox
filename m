Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRALVwe>; Fri, 12 Jan 2001 16:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbRALVwY>; Fri, 12 Jan 2001 16:52:24 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:41746 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129562AbRALVwS>; Fri, 12 Jan 2001 16:52:18 -0500
Date: Fri, 12 Jan 2001 16:52:05 -0500
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>
cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: generic_file_write change in 2.4.0-ac8
Message-ID: <23360000.979336325@tiny>
In-Reply-To: <Pine.GSO.4.21.0101121614150.20629-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, January 12, 2001 04:30:44 PM -0500 Alexander Viro
<viro@math.psu.edu> wrote:

> 
> 
> On Fri, 12 Jan 2001, Chris Mason wrote:
> 
>> 
>> Hi guys,
>> 
>> This code for generic_file_write calls vmtruncate without i_sem held.  Is
>> that intentional?  It should cause problems for reiserfs at least...
> 
> Erm... generic_file_write() grabs i_sem upon entry and drops it on exit.
> This call of vmtruncate() is deep inside the protected area.
> 

Yup, I'm trying to track down a different problem, and saw what I wanted to
instead of what was really there.  Sigh.  

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
