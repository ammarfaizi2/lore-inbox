Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316172AbSETR64>; Mon, 20 May 2002 13:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316175AbSETR6z>; Mon, 20 May 2002 13:58:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:273 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316172AbSETR6y>; Mon, 20 May 2002 13:58:54 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux-2.5.16
Date: Mon, 20 May 2002 17:57:39 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <acbdej$lig$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0205191736420.10180-100000@home.transmeta.com> <Pine.LNX.4.21.0205200245381.23394-100000@serv>
X-Trace: palladium.transmeta.com 1021917515 24961 127.0.0.1 (20 May 2002 17:58:35 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 20 May 2002 17:58:35 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0205200245381.23394-100000@serv>,
Roman Zippel  <zippel@linux-m68k.org> wrote:
>On Sun, 19 May 2002, Linus Torvalds wrote:
>>
>> No, that's just a missed thing (for a while I thought I could use "nr" for
>> "freed", so I changed the code and forgot to add back the free'd).
>
>If I see it correctly, tlb_remove_page() can't be called with a swap page,
>does it make sense to use free_page_and_swap_cache()?

tlb_remove_page() cannot be called with a swap _entry_, but it
absolutely can be (and often is) called with a page that is a swap
backing store page. So it does need free_page_and_swap_cache().

		Linus
