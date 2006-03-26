Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWCZRYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWCZRYz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 12:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWCZRYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 12:24:55 -0500
Received: from gateway.argo.co.il ([194.90.79.130]:25605 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1751270AbWCZRYz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 12:24:55 -0500
Message-ID: <4426CE5F.5070201@argo.co.il>
Date: Sun, 26 Mar 2006 19:24:47 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Arjan van de Ven <arjan@infradead.org>, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <1143376008.3064.0.camel@laptopd505.fenrus.org> <F31089B5-0915-439D-B218-009384E2148F@mac.com> <4426974D.8040309@argo.co.il> <25A7D808-9900-4035-BEB3-A782C5EF8EF4@mac.com>
In-Reply-To: <25A7D808-9900-4035-BEB3-A782C5EF8EF4@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Mar 2006 17:24:53.0196 (UTC) FILETIME=[31AAC8C0:01C650FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Mar 26, 2006, at 08:29:49, Avi Kivity wrote:
>> Kyle Moffett wrote:
>>> Well I guess you could call it UABI, but that might also imply that 
>>> it's _userspace_ that defines the interface, instead of the kernel.  
>>> Since the headers themselves are rather tightly coupled with the 
>>> kernel, I think I'll stick with the KABI name for now (unless 
>>> somebody can come up with a better one, of course :-D).
>>
>> How about __linux, or __linux_abi? There are ABIs for other 
>> components, and other OSes. Linux is the name of the project after all.
>
> The other thing that I quickly noticed while writing up the patches is 
> that it's kind of tedious typing __kabi_ over and over again.  I 
> actually did first try with __linux_abi_ but the typing effort and 
> finger cramps made me give up on that really quickly.
#define _LA(x) __linux_abi_##x

struct _LA(whatever) {
    int foo;
    int bar;
};

struct _LA(another) {
    ...
};

#undef _LA

?

-- 
error compiling committee.c: too many arguments to function

