Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWCGUiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWCGUiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 15:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWCGUiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 15:38:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:51154 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751108AbWCGUiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 15:38:04 -0500
X-Authenticated: #704063
Subject: Re: [Patch] Dead code in drivers/isdn/avm/avmcard.h
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20060307203059.GB705@ds20.borg.net>
References: <1141760900.7561.2.camel@alice>
	 <20060307203059.GB705@ds20.borg.net>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 21:38:02 +0100
Message-Id: <1141763882.8321.4.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 20:30 +0000, Thorsten Kranzkowski wrote:
> On Tue, Mar 07, 2006 at 08:48:20PM +0100, Eric Sesterhenn wrote:
> > hi,
> > 
> > this fixes coverity id #2. the if (i==0) is pretty useless,
> > since we assing i=0, just the line before.
> > Just compile tested.
> 
> Iff this is the right fix the comment should be removed as well, no?

updated patch below.

Signed-off-by: Eric Sesterhenn

--- linux-2.6.16-rc5-mm1/drivers/isdn/hardware/avm/avmcard.h.orig	2006-03-07 20:44:33.000000000 +0100
+++ linux-2.6.16-rc5-mm1/drivers/isdn/hardware/avm/avmcard.h	2006-03-07 21:34:31.000000000 +0100
@@ -437,9 +437,7 @@ static inline unsigned int t1_get_slice(
 #endif
 					dp += i;
 					i = 0;
-					if (i == 0)
-						break;
-					/* fall through */
+					break;
 				default:
 					*dp++ = b1_get_byte(base);
 					i--;


