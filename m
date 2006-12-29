Return-Path: <linux-kernel-owner+w=401wt.eu-S1030188AbWL2WQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWL2WQw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 17:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWL2WQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 17:16:52 -0500
Received: from 1wt.eu ([62.212.114.60]:1681 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965223AbWL2WQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 17:16:52 -0500
Date: Fri, 29 Dec 2006 23:16:40 +0100
From: Willy Tarreau <w@1wt.eu>
To: Mats Erik Andersson <mats.andersson64@comhem.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Three if-clauses of constant logic value; char drivers for kernel 2.4.33.3
Message-ID: <20061229221639.GO24090@1wt.eu>
References: <1166561978.4133.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166561978.4133.26.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 09:59:37PM +0100, Mats Erik Andersson wrote:
> Hi there, all masters of kernel code,

Hi !

> I just discovered that the kernel code for 2.4.33.3 contains three
> if-statements that never can change their values, whence they should
> be repaired or eliminated. In source directory linux/drivers/char the
> files vt.c and keyboard.c produce these warning upon compilation:
> 
>     vt.c:166: varning: comparison is always false due to limited range  
>               of data type
>     vt.c:289: varning: comparison is always false due to limited range
>               of data type
>     keyboard.c:640: varning: comparison is always true due to limited
>                     range of data type
> 
> I did the compilation with gcc 3.3.5 on Debian Sarge. This behaviour
> appeared first for kernel 2.2.19, since I wanted to revive the old
> minirtl edition, but to my surprise the same warnings appear also
> with the brand new kernel 2.4.33.3.

OK thanks for reporting this. I'll take a look at those before next
release.

BTW, sorry, I missed your post. When posting 2.4-related mails, please
try to put the "2.4" word close to the beginning of the subject so that
my eyes can notice it in the middle of the 10000 other montly messages
on LKML.

> Best regards
>              Mats Erik Andersson, PhD
>              ynglingatal@yahoo.se
>              mats.andersson64@comhem.se

best regards,
Willy

