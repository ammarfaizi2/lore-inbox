Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVIEQcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVIEQcD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVIEQcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:32:01 -0400
Received: from [81.2.110.250] ([81.2.110.250]:61333 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932331AbVIEQcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:32:00 -0400
Subject: Re: RFC: i386: kill !4KSTACKS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Alex Davis <alex14641@yahoo.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200509040930.57622.tomlins@cam.org>
References: <20050902060830.84977.qmail@web50208.mail.yahoo.com>
	 <200509041549.17512.vda@ilport.com.ua> <200509040930.57622.tomlins@cam.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Sep 2005 15:49:11 +0100
Message-Id: <1125845351.23858.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-09-04 at 09:30 -0400, Ed Tomlinson wrote:
> MS stuff.  We know that 4K stacks hurt the above.  Do we really want to break working
> configs just to enforce 4K stacks?  How does it hurt to make 4K the default and 
> allow 8K?  What _might_ make sense is to make 8K a reason to taint the kernel.

The question is whether ndiswrapper can do stack switching itself. Since
as I understand it the NT stack is way more than 8K. Is there anything
else needed so it (and perhaps in future other 'hard cases') can handle
stacks themselves. We have seperate IRQ stack handling already which
should also help this.

So what is needed to make it go away - specific technical items or just
the persuasive effect of having to fix it ?

