Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUATXFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265882AbUATXFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:05:13 -0500
Received: from gaia.cela.pl ([213.134.162.11]:36112 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S265879AbUATXFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:05:02 -0500
Date: Wed, 21 Jan 2004 00:04:49 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i386/mm and openwall change
In-Reply-To: <Pine.LNX.4.58.0401200817260.2123@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0401210000370.13857-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps, however I assumed that errorcode == 0 is a special case meaning 
no error, this seems to be suggested by the code.  If so then the ow 
approach differs from the current 25pre6 code.  The openwall sets it to 0 
meaning (I assume) no error, while the 25pre6 code sets it to a non-zero 
value, while the 24 code sets it to whatever errorcode was (can it be 
zero or nonzero? probably both, since this would explain the change 
in the first place...).  This effectively means we have 3 different 
function source-codes for the address>=TASK_SIZE case, while all behave 
identically for address<TASK_SIZE.

On Tue, 20 Jan 2004, Linus Torvalds wrote:
> On Tue, 20 Jan 2004, Maciej Zenczykowski wrote:
> > I'm assuming this means the openwall change was an error?
> 
> Oh, the openwall approach is fine too - the exact error number doesn't
> really matter much, and which one you choose is pretty much a matter of 
> taste.
> 		Linus

If it doesn't matter why set the bit at all?  If we do set the least
significant bit this is obviously because it shouldn't be zero (i.e. it
doesn't matter as long as it's boolean true), if so then why does ow set
it to zero in this case.  Obviously this is somehow _weird_...

Cheers,
MaZe.


