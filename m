Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbVAPUrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbVAPUrW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 15:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVAPUrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 15:47:22 -0500
Received: from tim.rpsys.net ([194.106.48.114]:61846 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262587AbVAPUrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 15:47:18 -0500
Message-ID: <037701c4fc0c$87abd910$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Rusty Russell" <rusty@rustcorp.com.au>, "Christoph Hellwig" <hch@lst.de>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       <adaplas@pol.net>,
       "lkml - Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <dwmw2@infradead.org>
References: <20050112203136.GA3150@lst.de> <1105575573.12794.27.camel@localhost.localdomain> <20050113170528.GA24590@lst.de> <1105685810.7311.96.camel@localhost.localdomain>
Subject: Re: [PATCH] kill symbol_get & friends
Date: Sun, 16 Jan 2005 20:46:07 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell:
> If it really wants dynamic symbol lookup, that's damn well what's going
> to happen.  intermodule must die.  If David doesn't want that feature
> any more, then sure, remove it.

I can see one scenario where symbol_get would appear to be useful. Say you 
have two modules A and B. Both can run independently of the other. If and 
only if both are loaded at the same time they need to exchange data.

Without symbol_get, you can only have hard dependencies between the modules 
and hence you would be forced into loading both modules even if you only 
want one of them.

I came across this function when trying to solve this exact problem. If the 
function is going to be removed, what is the alternative? Apologies if I've 
missed something obvious...

Richard 

