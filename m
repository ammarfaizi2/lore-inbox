Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbUKRKsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbUKRKsL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbUKRK3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:29:11 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:48256 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262725AbUKRK2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:28:45 -0500
Date: Thu, 18 Nov 2004 11:28:41 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Valdis.Kletnieks@vt.edu
cc: A M <alim1993@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Accessing program counter registers from within C or Aseembler.
In-Reply-To: <200411162133.iAGLXn7v018578@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.53.0411181127510.26614@yvahk01.tjqt.qr>
References: <20041116212015.32217.qmail@web51901.mail.yahoo.com>
 <200411162133.iAGLXn7v018578@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Does anybody know how to access the address of the
>> current executing instruction in C while the program
>> is executing?
>
>In other words, are you trying to answer "Where in memory am *I*?"
>or "Where in memory is <that very recent code I want to look at>?"
>
>(Hint - for the former, you can probably get very good approximations
>by just looking at the entry point address for the function:
>
>	(void *) where = &__FUNCTION__;

Well, that's only the function in which you are (i.e. it's an approximation to
EIP)

>> Also, is there a method to load a program image from
>> memory not a file (an exec that works with a memory
>> address)? Mainly I am looking for a method that brings
>> a program image into memory modify parts of it and
>> start the in-memory modified version.
>
>In user space, you probably want either mmap() or dlopen(), depending what it
>is you're trying to do, most likely...

Those pages will probably have NX set then, for archs which support it.




Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
