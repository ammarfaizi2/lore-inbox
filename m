Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281210AbRKHBBy>; Wed, 7 Nov 2001 20:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281220AbRKHBBq>; Wed, 7 Nov 2001 20:01:46 -0500
Received: from domino1.resilience.com ([209.245.157.33]:26623 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S281210AbRKHBB2>; Wed, 7 Nov 2001 20:01:28 -0500
Mime-Version: 1.0
Message-Id: <p05100303b80f8761af99@[10.128.7.49]>
In-Reply-To: <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu>
In-Reply-To: <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu>
Date: Wed, 7 Nov 2001 16:55:59 -0800
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: RE: Yet another design for /proc. Or actually /kernel.
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:13 PM -0600 11/7/01, Brenneke, Matthew Jeffrey (UMR-Student) wrote:
>  >> - Multiple values per file when needed
>>>	A file is a two dimensional array: it has lines and every line
>>>	can consist of multiple fields.
>>>	A good example of this is the current /proc/mounts.
>>>	This can be parsed very easily in all languages.
>>>	No need for single-value files, that's oversimplification.
>>>
>
>>Actually, /proc/mounts is currently broken, and is an excellent
>>example of why the above statement simply isn't true unless you apply
>>another level of indirection: try mounting something on a directory
>>the name of which contains whitespace in any form (remember, depending
>>on your setup this may be doable by an unprivileged user...)

If [tag plus] multiple values are allowed on a line, the field 
separation needs to be unambiguous. So quoting/escaping is required 
in some cases. Spaces are common enough in a value that white space 
maybe doesn't make a very good field separator.

Or just quote all strings (and escape quotes). Interpret values as C 
would, 0x for hex, "... for strings, and so on for floating point, 
octal, &c. Heck, you could even have typing (3UL) or casts, though 
that's probably going too far.
-- 
/Jonathan Lundell.
