Return-Path: <linux-kernel-owner+w=401wt.eu-S964964AbXAGT2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbXAGT2M (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbXAGT2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:28:11 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:56408 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964964AbXAGT2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:28:10 -0500
X-Originating-Ip: 74.109.98.176
Date: Sun, 7 Jan 2007 14:22:28 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Segher Boessenkool <segher@kernel.crashing.org>, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] math-emu/setcc: avoid gcc extension
In-Reply-To: <20070107111900.9d434162.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.64.0701071421400.13748@localhost.localdomain>
References: <20070106221947.8e01d404.randy.dunlap@oracle.com>
 <33e707f92df6b89a1c22f337f230cf32@kernel.crashing.org>
 <20070107104555.015aa79f.randy.dunlap@oracle.com>
 <974f8eb0d5984af6726a130082453916@kernel.crashing.org>
 <20070107111900.9d434162.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2007, Randy Dunlap wrote:

> On Sun, 7 Jan 2007 20:12:42 +0100 Segher Boessenkool wrote:
>
> > There's an extra tab in that last line.  Could you also
> > please fix the indenting (use a tab, not spaces) -- I know
> > it was there originally, but since there are only a few
> > lines in that file like that...  :-)
>
> how's this one?
> ---
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> setcc() in math-emu is written as a gcc extension statement
> expression macro that returns a value.  However, it's not used that
> way and it's not needed like that, so just make it a do-while
> non-extension macro so that we don't use an extension when it's not
> needed.

is that the proposed coding style for macros?  if it returns a value,
use "({ })"?  if not, use the "do ... while" notation?

rday
