Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWBSFlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWBSFlr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 00:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWBSFlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 00:41:47 -0500
Received: from relay4.usu.ru ([194.226.235.39]:215 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1750925AbWBSFlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 00:41:46 -0500
Message-ID: <43F8054E.1000805@ums.usu.ru>
Date: Sun, 19 Feb 2006 10:42:38 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Adam Tla/lka" <atlka@pg.gda.pl>
Cc: torvalds@osdl.org, bug-ncurses@gnu.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
References: <20060217233333.GA5208@sunrise.pg.gda.pl> <43F72C7A.8010709@ums.usu.ru>
In-Reply-To: <43F72C7A.8010709@ums.usu.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.1.0; VDF: 6.33.1.5; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> Adam Tla/lka wrote:

>> Changed console behaviour so in UTF-8 mode vt100 alternate character
>> sequences work as described in terminfo/termcap linux terminal 
>> definition.
>> Programs can use vt100 control seqences - smacs, rmacs and acsc  
>> characters
>> in UTF-8 mode in the same way as in normal mode so one definition is 
>> always
>> valid - current behaviour make these seqences not working in UTF-8 mode.
> 
> 
> Doesn't work here with linux-2.6.16-rc3-mm1, ncurses-5.5.

Sorry, that my non-true statement was due to the less-than-perfect 
description of the patch. After patching, this produces a horizontal line:

echo -e '\x0eqqqq\x0f'

So please correct the description and the first (comment) hunk of the 
patch, so that it doesn't mention "smacs" and similar words with meaning 
that may vary, and so that it mentions the exact control codes.

-- 
Alexander E. Patrakov
