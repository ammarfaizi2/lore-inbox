Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268340AbUJTPaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268340AbUJTPaO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268279AbUJTP2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:28:12 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:5813 "EHLO krynn.se.axis.com")
	by vger.kernel.org with ESMTP id S268166AbUJTPVr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:21:47 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Hugh Dickins'" <hugh@veritas.com>,
       "Mikael Starvik" <mikael.starvik@axis.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.9 PageAnon bug
Date: Wed, 20 Oct 2004 17:21:44 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66818F59B@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66801960A13@exmail1.se.axis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Ah, sorry for messing CRIS up, I was unaware of that.

Well, it's kind of odd nowadays to have the freedom of arbitrary alignment. 

>I don't think that's ugly, and the comment is good.
>It only actually needs "aligned(2)", would that be better?

Yes, aligned(2) is enough.

>But what does "aligned(2)" or "aligned(4)" do on 64-bit machines -
>any danger of it aligning stupidly?  I think not, but know little.

Same here, we need input from the 64-bit world (or make it aligned(8)).

>>Another possible patch would be to move i_data above i_bytes and i_sock.
>Really?  Precarious, I think you'd still need to insist on alignment.

I agree that there may be compilers out there that actually pads the
structure to make the members unaligned. So you are correct, aligned()
should be used to be safe (until memory allocation routines start to return
unaligned addresses).

Will you send this upstream to Andrew?

Thanks for the quick response!
/Mikael

