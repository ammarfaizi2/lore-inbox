Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262964AbUKRUR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbUKRUR0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbUKRUPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:15:08 -0500
Received: from [213.85.13.118] ([213.85.13.118]:900 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261158AbUKRUNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:13:42 -0500
To: fsdevel <owner-linux-fsdevel@vger.rutgers.edu>
Cc: Linus Torvalds <Torvalds@Osdl.ORG>, Miklos Szeredi <miklos@szeredi.hu>,
       hbryan@us.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
	<E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
	<E1CUquZ-0004Az-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.58.0411181027070.2222@ppc970.osdl.org>
	<E1CUrS0-0004Hi-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.58.0411181108140.2222@ppc970.osdl.org>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Thu, 18 Nov 2004 23:13:17 +0300
In-Reply-To: <Pine.LNX.4.58.0411181108140.2222@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 18 Nov 2004 11:16:31 -0800 (PST)")
Message-ID: <m1mzxeex0i.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

[...]

>
> We actually had (for a short while) code that tracked the dirty bit in 
> software (ie make it unwritable by default, and take the write fault), but 
> people showed that that was actually a real performance problem on some 
> loads.

Dirtiness can be tracked for a fraction of pages (for example, make pte
unwritable when page crosses active/inactive list boundary, or
alike). This will allow kernel to guarantee that there really is _known_
amount of clean pages in the system, without taking a lot of unnecessary
faults.

[... notes on kernel development methodology skipped ...]

>
> 		Linus

Nikita.
