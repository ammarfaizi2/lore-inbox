Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313925AbSEVN7N>; Wed, 22 May 2002 09:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314052AbSEVN7M>; Wed, 22 May 2002 09:59:12 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12808 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313925AbSEVN7K>; Wed, 22 May 2002 09:59:10 -0400
Message-Id: <200205221356.g4MDuCY03131@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Date: Wed, 22 May 2002 16:58:27 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, acme@conectiva.com.br
In-Reply-To: <5E8AE8C18EA@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 May 2002 11:40, Petr Vandrovec wrote:
> Function name is not documentation. Documentation documents function
> API, or, in case documentation is not available, source does it.
> copy_to_user_dude_I_return_uncopied_length_on_error_not_EFAULT_parameters_
>are_same_as_for_memcpy() is unacceptable name, and anything shorter does not
> document things you must know.

Anything can be taken to the ridiculous extreme: "let's use ci() and co()!
We will document 'em and everything will be fine!"

Let's abstain from this type of discussion.

> I'm not sure that I want to use kernel which contains code written
> by people who do not read API documentation. I expect that everyone
> here tests every branch in code he writes at least once - and such test
> would (f.e.) quickly reveal that read(fd, NULL, 1000) does not return -1 &
> set errno to EFAULT, but instead returns complete success (1000) on
> affected sound drivers.

In the ideal world. We're in the real world and there *is* broken code,
as demonstrated by Rusty. If we can reduce chances of programming errors by 
choosing good names, we have to do it.

Which name is 'good'/too short/too long is up to "big boys" to decide.
I presume they know better, I don't hack on kernel day and night. They do.
--
vda
