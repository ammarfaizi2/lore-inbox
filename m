Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVFZUfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVFZUfg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 16:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVFZUff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 16:35:35 -0400
Received: from mail.linicks.net ([217.204.244.146]:8715 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261576AbVFZUe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 16:34:59 -0400
From: Nick Warne <nick@linicks.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow number of IDE interfaces to be selected (X86)
Date: Sun, 26 Jun 2005 21:34:56 +0100
User-Agent: KMail/1.8.1
References: <200506251641.40922.nick@linicks.net> <1119808554.28649.37.camel@localhost.localdomain>
In-Reply-To: <1119808554.28649.37.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506262134.57000.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 June 2005 18:55, you wrote:

> I don't think this patch should go in - the one real reason for having
> it in embedded boxes was saving memory. The right fix for that is
> already something Bartlomiej has talked about fixing - the static
> allocation of the ide_hwifs array itself.

OK :-).

But I learnt a lot here on the kernel.

Also found not to cut 'n' paste from nano in X.  It doesn't perserve tabs... 
so the patch was bum anyway.  I only found out it was fubar when I was 
looking at what Matt done to get the struct sizes on different vmlinuz 
builds, and cut and paste back into a file from the mail.

But here is the results anyway using my .config but with the option off and 
on:


Orig (off):

bash-2.05b# nm -t d -rS --size-sort linux-2.6.12orig/vmlinux | grep hwifs
0000003225966208 0000000000014080 B ide_hwifs


With the IDE selection option (but not EMBEDDED) with 2 IDE interfaces 
selected (on with 2):

bash-2.05b# nm -t d -rS --size-sort linux-2.6.12/vmlinux | grep hwifs
0000003225974400 0000000000002816 B ide_hwifs


Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
