Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267194AbUGWJnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267194AbUGWJnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 05:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267455AbUGWJnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 05:43:20 -0400
Received: from CPE-144-131-112-134.nsw.bigpond.net.au ([144.131.112.134]:56825
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S267194AbUGWJnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 05:43:19 -0400
Message-ID: <4100DDAA.5030003@eyal.emu.id.au>
Date: Fri, 23 Jul 2004 19:43:06 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.6 (X11/20040530)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ankit Jain <ankitjain1580@yahoo.com>
CC: linux <linux-kernel@vger.kernel.org>
Subject: Re: working with mmx
References: <20040723075445.56108.qmail@web52902.mail.yahoo.com>
In-Reply-To: <20040723075445.56108.qmail@web52902.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ankit Jain wrote:
> actually the problem is i am not able to understand
> why this is not functiuoning
> 
> asm("mov %2,%0"
>     "mov %3,%1"
>     :"=r"(x),"=r"(y)
>     :"r"(a),"r"(b))
> 
> it gives assembler error

The two strings
	"mov %2,%0"
	"mov %3,%1"
get concatenated, try to separate them, e.g.
	"mov %2,%0\n"
	"mov %3,%1"

-- 
Eyal Lebedinsky	 (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
