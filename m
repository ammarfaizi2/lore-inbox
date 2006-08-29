Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWH2JaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWH2JaA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWH2JaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:30:00 -0400
Received: from mail.zelnet.ru ([80.92.97.13]:9684 "EHLO mail.zelnet.ru")
	by vger.kernel.org with ESMTP id S932253AbWH2J37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:29:59 -0400
Message-ID: <44F4090B.5010908@namesys.com>
Date: Tue, 29 Aug 2006 13:29:47 +0400
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@linuxmail.org>
CC: Stefan Traby <stefan@hello-penguin.com>, Hans Reiser <reiser@namesys.com>,
       Alexey Dobriyan <adobriyan@gmail.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Reiser4 und LZO compression
References: <20060827003426.GB5204@martell.zuzino.mipt.ru>	 <44F322A6.9020200@namesys.com> <20060828173721.GA11332@hello-penguin.com>	 <44F332D6.6040209@namesys.com> <1156801705.2969.6.camel@nigel.suspend2.net>
In-Reply-To: <1156801705.2969.6.camel@nigel.suspend2.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi.
> 
> On Mon, 2006-08-28 at 22:15 +0400, Edward Shishkin wrote:
> 
>>Stefan Traby wrote:
>>
>>>On Mon, Aug 28, 2006 at 10:06:46AM -0700, Hans Reiser wrote:
>>>
>>>
>>>
>>>>Hmm.  LZO is the best compression algorithm for the task as measured by
>>>>the objectives of good compression effectiveness while still having very
>>>>low CPU usage (the best of those written and GPL'd, there is a slightly
>>>>better one which is proprietary and uses more CPU, LZRW if I remember
>>>>right.  The gzip code base uses too much CPU, though I think Edward made
>>>
>>>
>>>I don't think that LZO beats LZF in both speed and compression ratio.
>>>
>>>LZF is also available under GPL (dual-licensed BSD) and was choosen in favor
>>>of LZO for the next generation suspend-to-disk code of the Linux kernel.
>>>
>>>see: http://www.goof.com/pcg/marc/liblzf.html
>>>
>>
>>thanks for the info, we will compare them
> 
> 
> For Suspend2, we ended up converting the LZF support to a cryptoapi
> plugin. Is there any chance that you could use cryptoapi modules? We
> could then have a hope of sharing the support.
> 

No problems with using crypto-api. Reiser4 bypasses it, because
currently it supplies the only compression level, which is fairly
bad for compressed file systems.

Edward.

