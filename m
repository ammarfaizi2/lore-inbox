Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbTBJUHd>; Mon, 10 Feb 2003 15:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265095AbTBJUHd>; Mon, 10 Feb 2003 15:07:33 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:53183 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S265066AbTBJUHc>; Mon, 10 Feb 2003 15:07:32 -0500
Subject: Re: [Lse-tech] gcc 2.95 vs 3.21 performance
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel@vger.kernel.org
Cc: velco@fadata.bg, mbligh@aracnet.com, davej@suse.de, ak@suse.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 10 Feb 2003 15:13:30 -0500
Message-Id: <1044908011.3133.123.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Momchil Velikov writes:
> "Martin" == Martin J Bligh <mbligh@aracnet.com> writes:

>> But the point is still the same ... even if it is doing
>> more agressive optimisation, it's not actually buying us
>> anything (at least for the kernel)
>
> which might be due in part to ``-fno-strict-aliasing''
> used to compile the Linux kernel.

This is fixable for any gcc implementing __may_alias__.

Linux uses -fno-strict-aliasing because people like
to cast a (foo*) to an (int*) instead of using a
union or (char*) as required by the C language.
When -fno-strict-aliasing was added to the command
line, gcc did not offer the __may_alias__ attribute.

BTW, in case any gcc hacker is paying attention,
the documentation fails to mention the gcc version
required for this or any other attribute. Also it
would be nice to have an option to ditch the (char*)
exception; it's junk when you have __may_alias__.


