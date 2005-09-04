Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVIDNbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVIDNbI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 09:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVIDNbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 09:31:08 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:57280 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1750822AbVIDNbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 09:31:07 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Sun, 4 Sep 2005 09:30:57 -0400
User-Agent: KMail/1.8.1
Cc: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
References: <20050902060830.84977.qmail@web50208.mail.yahoo.com> <200509041549.17512.vda@ilport.com.ua>
In-Reply-To: <200509041549.17512.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509040930.57622.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 September 2005 08:49, Denis Vlasenko wrote:
> On Friday 02 September 2005 09:08, Alex Davis wrote:
> > ndiswrapper and driverloader will not work reliably with 4k stacks.
> > This is because of the Windoze drivers they use, to which, obviously,
> > they do not have the source. Since quite a few laptops have built-in
> > wireless cards by companies who will not release an open-source driver,
> > or won't release specs, ndiswrapper and driverloader are the only way
> > to get these cards to work. 
> >   Please don't tell me to "get a linux-supported wireless card". I don't
> > want the clutter of an external wireless adapter sticking out of my laptop,
> > nor do I want to spend money on a card when I have a free and working solution.
> 
> Please don't tell me to "care for closed-source drivers". I don't
> want the pain of debugging crashes on the machines which run unknown code
> in kernel space.
> 
> IOW, if you run closed source modules - it's _your_ problem, not ours.
> --

There is no logic to the above statement.  We know when a kernel is tainted and
do not try hard to debug problems when tainted .  We also know that ndiswrapper
and friends _currently_ let people use hardware that otherwise would have to run
MS stuff.  We know that 4K stacks hurt the above.  Do we really want to break working
configs just to enforce 4K stacks?  How does it hurt to make 4K the default and 
allow 8K?  What _might_ make sense is to make 8K a reason to taint the kernel.

Ed Tomlinson

