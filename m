Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWEBN2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWEBN2X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWEBN2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:28:23 -0400
Received: from canuck.infradead.org ([205.233.218.70]:47018 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964809AbWEBN2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:28:23 -0400
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
From: David Woodhouse <dwmw2@infradead.org>
To: Johannes Stezenbach <js@linuxtv.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
In-Reply-To: <20060502003755.GA26327@linuxtv.org>
References: <20060430174426.a21b4614.rdunlap@xenotime.net>
	 <1146503166.2885.137.camel@hades.cambridge.redhat.com>
	 <20060502003755.GA26327@linuxtv.org>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 May 2006 14:28:15 +0100
Message-Id: <1146576495.14059.45.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-02 at 02:37 +0200, Johannes Stezenbach wrote:
> IMHO u32 etc. are the well established data types used
> everywhere in kernel source. Your wording suggests that
> the use of C99 types would be better, and while I respect
> your personal opinion, I think it is wrong to put that in the
> kernel CodingStyle document.

Perhaps the word 'gratuitous' should be removed, then, if you object to
being able to infer my opinion.

The point remains that the peculiarity should definitely be documented,
along with an explanation of the reasoning (or lack of such) behind it.

> c.f. http://lkml.org/lkml/2004/12/14/127 

That's about types used for _export_. It's accepted that __uXX types are
necessary in stuff which is visible by userspace. That was point (e).¹

The only bit in that mail which is relevant to my point (d) is the
penultimate (and final) paragraphs. And those are a complete non
sequitur and make just as much sense if you swap over 'u32' and
'uint32_t' and also 'kernel' and 'C language'...

"In other words, uint8_t/uint16_t/uint32_t/uint64_t (and the signed
versions: int8_t and friends) _are_ the standard names in the C
language, and the __u8/__u16/etc versions have always existed alongside
them for things like header files that have namespace issues.

"So forget about that stupid abortion called "u32" already. It buys
you absolutely nothing."

-- 
dwmw2

¹ Actually I had a conversation with Uli the other day in which he
seemed to suggest that proper C99 types _would_ be better, but let's not
go there for now.

