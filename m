Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292291AbSBTUbO>; Wed, 20 Feb 2002 15:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292285AbSBTUa5>; Wed, 20 Feb 2002 15:30:57 -0500
Received: from quark.didntduck.org ([216.43.55.190]:15115 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S292288AbSBTUao>; Wed, 20 Feb 2002 15:30:44 -0500
Message-ID: <3C74076C.C2606C95@didntduck.org>
Date: Wed, 20 Feb 2002 15:30:36 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jason Yan <jasonyanjk@yahoo.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: initialize page tables --  Re: paging question
In-Reply-To: <20020220195513.EIBW1236.tomts21-srv.bellnexxia.net@abc337>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Yan wrote:
> 
> Thank you Dick
> 
> Oops, I use a wrong subject, what I want to ask is how the pg0 be initialized
> 
> in head.S,
> 
> 395 .org 0x2000
> 396 ENTRY(pg0)
> 
> so $pg0-__PAGE_OFFSET = 0x2000 - 0xC0000000 = 40002000, how comes bff00000 ?

That's offset 0x2000 from the beginning of head.o, which is at virtual
address 0xc0100000, meaning the final value of pg0 is 0xc0102000. 
Subtract __PAGE_OFFSET and you get physical address 0x00102000.

--

				Brian Gerst
