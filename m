Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVCMAUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVCMAUG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 19:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVCMAUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 19:20:06 -0500
Received: from main.gmane.org ([80.91.229.2]:27868 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261266AbVCMAUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 19:20:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kevin Puetz <puetzk@puetzk.org>
Subject: Re: The address displayed by ldd
Date: Sat, 12 Mar 2005 18:19:41 -0600
Message-ID: <d100te$ina$1@sea.gmane.org>
References: <20050312151253.60839.qmail@web53906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 12-219-13-19.client.mchsi.com
User-Agent: KNode/0.8.2
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner-SpamScore: s
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's the load address of the library, and it's basically not meant to be a
stable value. It will at least depend on the load order and size of the
libraries, and it may in fact be intentionally randomized each run as a
security measure against ret2libc type attacks (PaX, execshield, etc all do
this, as does prelink everytime it re-prelinks libraries). It's entirely
plausible for it to change from run to run, much less machine to machine.

gan_xiao_jun@yahoo.com wrote:

> Hi,
> 
> I have a small question,
> I am not sure if it belongs to kernel.
> I often use ldd to find librarys needed.
> In some systems,the address display by ldd not
> changes,
> But in other systems, it changes.
> 
> What is the reason of the difference?
> Is it cause by some setting in kernel?
> 
> Thanks in advance.
> gan
> 
> 
> 
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! Mail - Find what you need with new enhanced search.
> http://info.mail.yahoo.com/mail_250


