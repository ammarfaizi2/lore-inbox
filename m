Return-Path: <linux-kernel-owner+w=401wt.eu-S965110AbXATDqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbXATDqO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 22:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbXATDqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 22:46:14 -0500
Received: from web36713.mail.mud.yahoo.com ([209.191.85.47]:23793 "HELO
	web36713.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965110AbXATDqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 22:46:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=UbXZrv3Yrpr7upW4XoUHgeHTEimIdJK41d7JkBnX/l2fQnyhtIi7jdlrlpfysKDg4vb5pgUVGwV/fTLBlF2LoywmGt+lCjL9S1hF/4Dx0JzilKCBez1Pt0OwiqDNMAyfNLS7oBWlcf1RyMVgLSFBXaPJS+AWHBT1WAVN9/g53iU=;
X-YMail-OSG: KWOQ85cVM1mcnaIO2Dhh5tStIJ19QwjL5U9HS6zAoChtd7UUOcmLgV7Ar7UUckTW9oDXx_mqQ2AbIyKojPrzcNhfS1rWJuxTlSsRY.gmhvOwVaCCg2vNZbaMtoM8CGbBVUENZm1lfe3Id5rP5ufz5v1TOZA1YP.M
Date: Fri, 19 Jan 2007 19:46:12 -0800 (PST)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: mmc: correct semantics of the mmc_host_remove
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45B085AA.70109@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <859705.85986.qm@web36713.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That shouldn't be possible. Are you using the block queue fixes I wrote?
> Otherwise you will get problems like this.
> 
> Basically, when you call mmc_host_remove(), it will remove all card
> devices. That shouldn't complete until all card drivers have released
> control of the card. At that point there is no one else accessing the
> device. If you see something else, then we have a bug somewhere.
> 
Indeed, I may be out of sync on this. Simply, I have this rather ugly hack in the tifm_sd remove
code which I was forced to add because of the issue in question.
I'll do some tests with newer kernels then.



 
____________________________________________________________________________________
Now that's room service!  Choose from over 150,000 hotels
in 45,000 destinations on Yahoo! Travel to find your fit.
http://farechase.yahoo.com/promo-generic-14795097
