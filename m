Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVFQJlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVFQJlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 05:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVFQJlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 05:41:20 -0400
Received: from quechua.inka.de ([193.197.184.2]:34252 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261927AbVFQJlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 05:41:16 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <200506170450.12943.pmcfarland@downeast.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DjDLd-0007rU-00@calista.eckenfels.6bone.ka-ip.net>
Date: Fri, 17 Jun 2005 11:41:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200506170450.12943.pmcfarland@downeast.net> you wrote:
> (implication of utf8 and not utf16 goes here)
> 
> Very few Unicode characters require three bytes, instead of the usual one or 
> two.

UTF-8 2 bytes end with U+07ff which covers only Latin, Cyrillic, Hebrew and
Arabic.

All JCK Unified Ideographs  (U+4E00-) and Extensions (U+3400-) have 3 byte
encodings with UTF-8. Some of the B Extensions even use 4 bytes (U+20000-)

> For one byte you just have the byte. 

For ASCII you have one byte.

> For two bytes, you really have three: a control code stating "the following 
> two bytes are a two byte character", and then the two bytes. 

Umm, thats a bit missleading. UTF-8 works with bit not byte prefixes.
Unicode code points are integers and depending on the encoding represented
as multiple code points, which can be represented as bytes.

> Unless I've completely misunderstood the Unicode specification, this is what 
> is going on.

You might want to look up Joel's Tutorial or just browse the Unihan Database:
http://www.joelonsoftware.com/articles/Unicode.html
http://www.unicode.org/cgi-bin/GetUnihanData.pl?codepoint=3400
http://www.unicode.org/cgi-bin/UnihanGrid.pl?codepoint=U+07F1&useutf8=false

Greetings
Bernd
