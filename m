Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261886AbSKCOLv>; Sun, 3 Nov 2002 09:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261893AbSKCOLq>; Sun, 3 Nov 2002 09:11:46 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:28632 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S261886AbSKCOLo>; Sun, 3 Nov 2002 09:11:44 -0500
Message-ID: <3DC53026.5080205@quark.didntduck.org>
Date: Sun, 03 Nov 2002 09:18:14 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Brian Gerst <bgerst@didntduck.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Dead code in i386 math-emu
References: <3DC49ABE.2020801@quark.didntduck.org> <1036327073.29646.4.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sun, 2002-11-03 at 03:40, Brian Gerst wrote:
> 
>>This removes unused non-reentrant code in the fpu emulator.
> 
> 
> Why remove it - it might actually be useful some day and its doing no
> harm ?
> 

Why keep it?  All it does is put the variables (28 bytes at most) in 
global space instead of on the stack.  There is no need to have it both 
ways.

--
				Brian Gerst

