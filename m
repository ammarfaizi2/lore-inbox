Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266071AbTLIPpR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 10:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbTLIPpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 10:45:17 -0500
Received: from terminus.zytor.com ([63.209.29.3]:45028 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S266071AbTLIPpO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 10:45:14 -0500
Message-ID: <3FD5ED77.6070505@zytor.com>
Date: Tue, 09 Dec 2003 07:42:47 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Nikita Danilov <Nikita@Namesys.COM>, linux-kernel@vger.kernel.org
Subject: Re: const versus __attribute__((const))
References: <200312081646.42191.arnd@arndb.de> <Pine.LNX.4.58.0312082321470.18255@home.osdl.org> <3FD57C77.4000403@zytor.com> <200312091256.47414.arnd@arndb.de>
In-Reply-To: <200312091256.47414.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> 
> For reference, both gcc-3.3 and gcc-3.4 (snapshot) give produce the same assembly 
> as gcc-3.2 for your code, but give this warning:
> 
> test.c:6: warning: use of memory input without lvalue in asm operand 1 is deprecated
> test.c:7: warning: use of memory input without lvalue in asm operand 1 is deprecated
> 

In some ways, this is rather unfortunate, too.  What it really means is 
that the gcc "m" constraint is overloaded; it would have been better if 
they would have created a new modifier (say "*") for "must be lvalue."

	-hpa

