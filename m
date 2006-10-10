Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbWJJJwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWJJJwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 05:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWJJJwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 05:52:36 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:39357 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965145AbWJJJwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 05:52:34 -0400
Date: Tue, 10 Oct 2006 11:41:15 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Schwab <schwab@suse.de>
cc: David Howells <dhowells@redhat.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Matthew Wilcox <matthew@wil.cx>, torvalds@osdl.org, akpm@osdl.org,
       sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in
 the kernel [try #4]
In-Reply-To: <je4pudns4g.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.61.0610101140490.19891@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610091416290.4279@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr>
 <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr> <20061006203919.GS2563@parisc-linux.org>
 <5267.1160381168@redhat.com> <Pine.LNX.4.61.0610091032470.24127@yvahk01.tjqt.qr>
 <EE65413A-0E34-40DA-9037-72423C18CD0C@mac.com> <11639.1160398461@redhat.com>
 <Pine.LNX.4.61.0610092159340.23379@yvahk01.tjqt.qr> <je4pudns4g.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> typedef uint32_t __u32;
>>>
>>>That only offsets the problem a bit.  You still have to derive uint32_t from
>>>somewhere.
>>
>> The compiler could make it available as a 'fundamental type' - i.e. 
>> available without any headers, like 'int' and 'long'.
>
>The compiler is not allowed to define uint32_t without including
><stdint.h> first.

Well no problem, stdint.h may just have

typedef __secret_compiler_provided_uint32_t uint32_t;


	-`J'
-- 
