Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932648AbWKEL2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbWKEL2l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 06:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWKEL2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 06:28:41 -0500
Received: from wasp.net.au ([203.190.192.17]:22246 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S932648AbWKEL2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 06:28:41 -0500
Message-ID: <454DCAAC.3080903@wasp.net.au>
Date: Sun, 05 Nov 2006 15:27:40 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Cahalan <acahalan@gmail.com>,
       kangur@polcom.net, mikulas@artax.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
References: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com> <1162691856.21654.61.camel@localhost.localdomain> <454DC799.9000401@superbug.co.uk>
In-Reply-To: <454DC799.9000401@superbug.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:

> I have seen this too. I think that when IDE drive relocates the sector 
> due to hard errors, one would silently loose the information that was 
> stored in that sector.
> How can one detect this? Of course it would be nice if the IDE drive 
> told us that sector X had just gone bad but I don't think they do. They 
> just silently relocate it because in some cases the sector has only gone 
> a "bit" bad, so the IDE drive relocates it before it totally fails.

I've never seen this behaviour in a drive. All the drives I've seen mark bad sectors as "pending 
reallocation", they they return read errors on that sector unless they manage to jag a good read, in 
which case they then reallocate the sector. Or else they wait for you to write to the sector 
triggering a reallocation.

There may be drives less well behaved out there, but I've not come across them.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
