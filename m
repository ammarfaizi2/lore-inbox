Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbVJUPhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbVJUPhf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbVJUPhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:37:35 -0400
Received: from mail.avalus.com ([195.82.114.197]:52432 "EHLO shed.alex.org.uk")
	by vger.kernel.org with ESMTP id S964988AbVJUPhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:37:34 -0400
Date: Fri, 21 Oct 2005 16:37:22 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Arjan van de Ven <arjan@infradead.org>,
       "Vincent W. Freeh" <vin@csc.ncsu.edu>
Cc: linux-kernel@vger.kernel.org,
       Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Understanding Linux addr space, malloc, and heap
Message-ID: <9EF45D4BE7AB7134B6342106@Satori.nominet.org.uk>
In-Reply-To: <1129908179.2786.23.camel@laptopd505.fenrus.org>
References: <4358F0E3.6050405@csc.ncsu.edu>	
 <1129903396.2786.19.camel@laptopd505.fenrus.org>	
 <4359051C.2070401@csc.ncsu.edu>
 <1129908179.2786.23.camel@laptopd505.fenrus.org>
X-Mailer: Mulberry/4.0.4 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On 21 October 2005 17:22 +0200 Arjan van de Ven <arjan@infradead.org> 
wrote:

> Ok I meant in the "while adhering to the standard" :)

More precisely, as per the man page:
> POSIX.1b says that mprotect can be used only on regions of memory
> obtained from mmap(2).

But what is interesting (if anything) is this:
> ERRORS
>        EINVAL addr is not a valid pointer, or not a  multiple  of
>        PAGESIZE.

So if he calls mprotect with memory allocated by malloc (which should
fail), why doesn't he get EINVAL? He says it returns 0 (meaning it
succeeded). Which it shouldn't (unless he is stupendously lucky in
malloc's allocation, in which case it should work).

--
Alex Bligh
