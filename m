Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUGHQaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUGHQaC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 12:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUGHQaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 12:30:02 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:61711 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262450AbUGHQ36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 12:29:58 -0400
Message-ID: <40ED7BE7.7010506@techsource.com>
Date: Thu, 08 Jul 2004 12:52:55 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> <40ED71BC.2030609@techsource.com> <Pine.LNX.4.58.0407080917420.1764@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0407080917420.1764@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:

> 
> I've seen too damn many people mistake NULL and NUL (admit it, you've seen 
> it too), and I've seen code like
> 
> 	char c = NULL;

THIS is simply a case of the programmer not understanding what NULL 
means.  When I use '0' for a pointer, I know EXACTLY what I mean, and I 
also know when '0' might be ambiguous, and when I don't know what I'm 
allowed to do, then I play it REALLY safe and typecast 0 to exactly the 
pointer type I need.

I suppose it's good form to use the safest syntax in all cases.  Good 
for readability for people who need more redundancy to read the code.

Perhaps the Linux kernel should have a convention where all NULL 
pointers are typecast explicitly.  I can hear the cries of pain already.  :)


