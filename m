Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272002AbTHRPWF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272046AbTHRPWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:22:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:20155 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272002AbTHRPWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:22:01 -0400
Date: Mon, 18 Aug 2003 08:21:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries.Brouwer@cwi.nl
cc: Dominik.Strasser@t-online.de, <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
In-Reply-To: <UTC200308181219.h7ICJfw14963.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0308180820470.1672-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Aug 2003 Andries.Brouwer@cwi.nl wrote:
> 
> I see that Linus already applied this, but I am quite unhappy with
> these changes. Entirely needlessly user space software is broken.

If it's supposed to be exported to user space, it _still_ must not use 
"u_char", since that isn't namespace-clean.

If it needs exporting, it must use "__u8".

			Linus

