Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313356AbSDOXOk>; Mon, 15 Apr 2002 19:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313358AbSDOXOj>; Mon, 15 Apr 2002 19:14:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32782 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313356AbSDOXOi>; Mon, 15 Apr 2002 19:14:38 -0400
Message-ID: <3CBB5ECB.2040002@zytor.com>
Date: Mon, 15 Apr 2002 16:14:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020312
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: link() security
In-Reply-To: <E16xFtQ-0007Gp-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>>And then unrealized when they hit performance limitations. Its a trade off
>>>and one that most news systems seem to prefer to use a custom database
>>>for
>>
>>Well, a database is basically a custom filesystem.
> 
> I would have to disagree. There are fundamentally different transaction
> semantics between the two as well as indexing constraints. I can't for
> example find commit() and rollback() in posix.1 8)
> 

OK, perhaps I should have been more explicit...

A filesystem is *one kind* of database.

The operations that various databases implement differ -- not all
databases have commit()/rollback(), nor do all of them implement
relationals, object linking, etc.

The point was mostly that storing mail in a (basically) unstructured
flat-file format isn't really consistent with the operations you want to
perform on it.  I didn't mean the directory/file format was necessarily
the ultimate solution, only that (a) it works better than mbox, (b) it's
been around for a long time.

	-hpa

