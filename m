Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbTLHRuv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbTLHRuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:50:51 -0500
Received: from terminus.zytor.com ([63.209.29.3]:56528 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262901AbTLHRut
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:50:49 -0500
Message-ID: <3FD4B9E6.9090902@zytor.com>
Date: Mon, 08 Dec 2003 09:50:30 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: const versus __attribute__((const))
References: <200312081646.42191.arnd@arndb.de>
In-Reply-To: <200312081646.42191.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> H. Peter Anvin writes:
> 
>>I have made a patch against the current tree defining
>>__attribute_const__ in <linux/compiler.h> and using it in the above
>>cases; does anyone know any reason why I should *NOT* submit this to
>>Linus?
> 
> 
> I noticed before that gcc appearantly ignores __attribute__((const))
> for inline functions, so both the original and your proposed code
> is rather pointless as an optimization, except for extern declarations.
> 
> I'd rather remove the 'const' completely where it causes warnings for
> inline functions.
> 

These functions are available to userspace, though, and can be compiled 
with -O0; thus not inlined.

	-hpa

