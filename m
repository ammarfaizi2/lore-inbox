Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316824AbSGVLSr>; Mon, 22 Jul 2002 07:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316823AbSGVLRv>; Mon, 22 Jul 2002 07:17:51 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:35110 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S316757AbSGVLRk>; Mon, 22 Jul 2002 07:17:40 -0400
Message-Id: <200207221119.g6MBJgV26234@gum09.etpnet.phys.tue.nl>
Date: Mon, 22 Jul 2002 13:19:40 +0200 (CEST)
From: bart@etpmod.phys.tue.nl
Reply-To: bart@etpmod.phys.tue.nl
Subject: Re: [PATCH] 2.5.27 sysctl
To: linux-kernel@vger.kernel.org
In-Reply-To: <3D3BE4C7.2060203@evision.ag>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jul, Marcin Dalecki wrote:
> Christoph Hellwig wrote:
>> On Mon, Jul 22, 2002 at 12:42:07PM +0200, Marcin Dalecki wrote:
>> 
>>>This is making the sysctl code acutally be written in C.
>>>It wasn't mostly due to georgeous ommitted size array "forward
>>>declarations". As a side effect it makes the table structure easier to
>>>deduce.
>> 
>> 
>> Please don't remove the trailing commas in the enums.  they make adding
>> to them much easier and are allowed by gcc (and maybe C99, I'm not
>> sure).
> 
> It's an GNU-ism. If you have any problem with "adding vales", just
> invent some dummy end-value. I have a problem with using -pedantic.
> 

Trailing commas in enums were NOT allowed before C99. C99 allows them,
and gcc and some other compilers allowed this syntax before C99. 
Since the kernel is going to use the .field= (C99) syntax for structure
initialisers anyway, I don't see any point in removing trailing commas.
(Especially not in code I once wrote :-))

As an aside, the fact that gcc warns about them is probably a compiler
bug: (http://gcc.gnu.org/c99status.html)
'In some places, -pedantic warnings don't take proper account of the
standard version selected.'

Bart

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Bart Hartgers - TUE Eindhoven 
http://plasimo.phys.tue.nl/bart/contact.html
