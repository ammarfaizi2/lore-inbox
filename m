Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbVA0TfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbVA0TfY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 14:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVA0TfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 14:35:24 -0500
Received: from p-mail1.rd.francetelecom.com ([195.101.245.15]:38414 "EHLO
	p-mail1.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S262712AbVA0TfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:35:05 -0500
Message-ID: <41F9425A.2030101@francetelecom.REMOVE.com>
Date: Thu, 27 Jan 2005 20:34:50 +0100
From: Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Patch 0/6  virtual address space randomisation
References: <20050127101117.GA9760@infradead.org>	 <41F8D44D.9070409@francetelecom.REMOVE.com> <1106827050.5624.81.camel@laptopd505.fenrus.org> <41F927F2.2080100@comcast.net>
In-Reply-To: <41F927F2.2080100@comcast.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2005 19:34:00.0308 (UTC) FILETIME=[26920340:01C504A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Yeah, if it came from PaX the randomization would actually be useful.
> Sorry, I've just woken up and already explained in another post.
> 

Please, no hard feelings.

Speaking about implementation of the non executable pages semantics on 
IA32, PaX and Exec-Shield are very different (well not that much since 
2.6 in fact because PAGEEXEC is now "segmentation when I can").
But when it comes to ASLR it's pretty much the same thing.

The only difference may be the (very small) randomization of the brk() 
managed heap on ET_EXEC (which is probably the more "hackish" feature of 
PaX ASLR) but it seems that Arjan is even going to propose a patch for 
that (Is this in ES too ?).

I think it's a great opportunity here to get the same basis for ASLR in 
PaX and ES merged into the vanilla kernel.
If it's only a matter of changing the number of randomized bits in an 
additional PaX patch, it's no problem! It's more important to have a 
correct basis, focus on that.

-- 
Julien TINNES - & france telecom - R&D Division/MAPS/NSS
Research Engineer - Internet/Intranet Security
GPG: C050 EF1A 2919 FD87 57C4 DEDD E778 A9F0 14B9 C7D6
