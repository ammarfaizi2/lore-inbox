Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTIHWIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbTIHWIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:08:48 -0400
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:21382 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S263612AbTIHWIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:08:46 -0400
Message-ID: <3F5CFCF2.7080308@upb.de>
Date: Tue, 09 Sep 2003 00:04:34 +0200
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: de, en
MIME-Version: 1.0
To: Paul Clements <Paul.Clements@SteelEye.com>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [NBD] patch and documentation
References: <3F5CB554.5040507@upb.de> <20030908193838.GA435@elf.ucw.cz> <3F5CE0E5.A5A08A91@SteelEye.com> <3F5CE3E6.8070201@upb.de> <3F5CF045.DDDE475C@SteelEye.com>
In-Reply-To: <3F5CF045.DDDE475C@SteelEye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please see http://imap.upb.de for details
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-25.4, required 4,
	IN_REP_TO -3.30, QUOTED_EMAIL_TEXT -3.20, REFERENCES -6.60,
	REPLY_WITH_QUOTES -6.50, USER_AGENT_MOZILLA_UA -5.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Well, i guess the cache uses a value of 256 sectors to do read-ahead and
>>such.
> 
> Well it sounds like the real problem here is the vm_max_readahead
> setting then. Try this:

I will try it, although i think that i'm using the deafult values.

Anyway: the NBD module should set the max_sectors to a certain value - i 
chose 256 sectors. Perhaps Pavel or Paul may decide to use a higher ot 
smaller value. A limit should be part of the protocol or handshaked when 
connecting to the server (what is not possible without changing the 
protocol)

