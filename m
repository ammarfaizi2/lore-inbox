Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313589AbSDHIq3>; Mon, 8 Apr 2002 04:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313588AbSDHIq2>; Mon, 8 Apr 2002 04:46:28 -0400
Received: from fungus.teststation.com ([212.32.186.211]:3337 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S313589AbSDHIq0>; Mon, 8 Apr 2002 04:46:26 -0400
Date: Mon, 8 Apr 2002 10:46:04 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Re: 2.4.19-pre6 dead Makefile entries
In-Reply-To: <m3elhrjkjk.fsf@lugabout.jhcloos.org>
Message-ID: <Pine.LNX.4.33.0204081015300.7289-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Apr 2002, James H. Cloos Jr. wrote:

> >> fs/nls/Makefile nls_cp1252.o
> 
> It does seem as though this one would be useful to a significant
> number of people.  Is there some reason 125[2-46-8] are not included
> where the rest are?  

Perhaps they aren't used in a form that makes any linux fs see them.

cp1252 is not the codepage used by a windows smb server so you wouldn't
need it for smbfs (same for vfat, ncpfs?), it would return data in the
corresponding dos codepage (cp850). NTFS is unicode. cd/dvd formats are 
... (?)

Maybe I'm missing something.


> uniset to output the necessary data.  In fact, it seems like it would
> be better to include the unicode table files in the kernel tree and
> use a utility to generate the nls...c files as needed, yes?)

I think so. A tool to build them would be nice, cp1252 or not. I did some
editing before on them and the editor was perl (ok, so I suck at using awk
and sed ...).

Some format that allows different implementations to be used. All the
iso* pages could share one implementation file but let the more advanced
have different. That could of course be done with a simple "#include".

/Urban

