Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTLHScE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTLHScE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:32:04 -0500
Received: from terminus.zytor.com ([63.209.29.3]:25809 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261779AbTLHScA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:32:00 -0500
Message-ID: <3FD4C375.2060803@zytor.com>
Date: Mon, 08 Dec 2003 10:31:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: const versus __attribute__((const))
References: <200312081646.42191.arnd@arndb.de>	<3FD4B9E6.9090902@zytor.com> <16340.49791.585097.389128@laputa.namesys.com>
In-Reply-To: <16340.49791.585097.389128@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
>  > 
>  > These functions are available to userspace, though, and can be compiled 
>  > with -O0; thus not inlined.
> 
> And future versions of gcc can be smarter.
> 

Actually, the reason it doesn't use it for the inlines is because it 
doesn't need to -- it already has full visibility, so it doesn't need it 
to be spelled out.

So it would be an issue if gcc got dumber, not smarter.

	-hpa

