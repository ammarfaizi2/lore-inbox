Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263883AbTIIA5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 20:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263888AbTIIA5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 20:57:08 -0400
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:50390 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S263883AbTIIA5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 20:57:05 -0400
Message-ID: <3F5D2455.9070004@upb.de>
Date: Tue, 09 Sep 2003 02:52:37 +0200
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: de, en
MIME-Version: 1.0
To: Paul Clements <Paul.Clements@SteelEye.com>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [NBD] patch and documentation
References: <3F5CB554.5040507@upb.de> <20030908193838.GA435@elf.ucw.cz> <3F5CE0E5.A5A08A91@SteelEye.com> <3F5CE3E6.8070201@upb.de> <3F5CF045.DDDE475C@SteelEye.com> <3F5CFF0B.6080609@upb.de> <20030908222111.GG429@elf.ucw.cz> <3F5D0186.4030001@upb.de> <20030908232824.GH429@elf.ucw.cz> <3F5D2336.A1AF2EBF@SteelEye.com>
In-Reply-To: <3F5D2336.A1AF2EBF@SteelEye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please see http://imap.upb.de for details
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-25.4, required 4,
	IN_REP_TO -3.30, QUOTED_EMAIL_TEXT -3.20, REFERENCES -6.60,
	REPLY_WITH_QUOTES -6.50, USER_AGENT_MOZILLA_UA -5.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I believe that 1MB is good, and good enough for close future. If that
>>ever proves to be problem, we can add handshake at that point. But I
>>do not believe it will be neccessary.
> 
> But, who ever said the buffer in the nbd-server had to be statically
> allocated? I have a version of nbd-server that is modified to handle any
> size request that the client side throws at it -- if the buffer is not
> large enough, it simply reallocates it.

Well, imagine that somebody develops a server implementation (well, that 
was what some friends and me did in the past few days) than it is just 
good to know, that there is a limit for the length field of the 
request-packet. If there is no limit, the server implementation has to 
be abled to answer requests of any size. That is very complicated.
For example if the server has only 64MB of memeory, and the kernel would 
be abled to send a 128MB request, how would you handle that?

