Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267994AbUBRUCJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267995AbUBRUCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:02:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4613 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S267994AbUBRUCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:02:04 -0500
Message-ID: <4033C48E.8020409@zytor.com>
Date: Wed, 18 Feb 2004 12:01:18 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Tomas Szepe <szepe@pinerecords.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202142.GA5834@outpost.ds9a.nl> <c0ukd2$3uk$1@terminus.zytor.com> <Pine.LNX.4.58.0402171910550.2686@home.osdl.org> <4032DA76.8070505@zytor.com> <Pine.LNX.4.58.0402171927520.2686@home.osdl.org> <4032F861.3080304@zytor.com> <Pine.LNX.4.58.0402180716180.2686@home.osdl.org> <20040218194744.GB1537@louise.pinerecords.com>
In-Reply-To: <20040218194744.GB1537@louise.pinerecords.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe wrote:
> On Feb-18 2004, Wed, 07:35 -0800
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
>>But it makes perfect sense to use a policy of:
>> - escape valid UTF-8 characters as '\u7777'

[And e.g. \U00017777 for characters above \uFFFF]

>> - escape _invalid_ UTF-8 characters as their hex byte sequence (ie 
>>   '\xC0\x80\x80', whatever)
>> - (and, obviously, escape the valid UTF-8 character '\' as '\\').
>>
>>Don't you agree? It clearly allows all the cases, and you can re-generate 
>>the _exact_ original stream of bytes from the above (ie it is nicely 
>>reversible, which in my opinion is a requirement).
> 
> I really really hope this is _exactly_ what we're going to see in practice.
> 

Same here.  This is clearly The Right Thing[TM].

	-hpa

