Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267294AbUH2NVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUH2NVS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 09:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUH2NVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 09:21:17 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:28566 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP id S267294AbUH2NVN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 09:21:13 -0400
Date: Sun, 29 Aug 2004 15:21:11 +0200
Message-Id: <1248395717@web.de>
MIME-Version: 1.0
From: "Joachim Bremer" <joachim.bremer@web.de>
To: "JoachimBremer" <joachim.bremer@web.de>,
       "NickPiggin" <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: <no subject>
Organization: http://freemail.web.de/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> schrieb am 29.08.04 14:43:43:
> 
> Joachim Bremer wrote:
> > As mentioned before I got even with Nicks patch some errors. Looking
> > closer at the source there is is a second "goto page_ok" a few lines
> > down the label "page_not_up_to_date". Inserting the same calculating
> > code used before the label "readpage_error" fixes the errors on my machine.
> > These for instance where failure to do reiserfsck (bread complains on last block
> > of device) and compiling the linux-tree (file truncated).
> > 
> > The leads to the same calculation 3 times...
> > 
> 
> Surely not - there is only 1 way to get to page_not_up_to_date,
> and through that path you have already done that calculation and
> none of the variables involved have been changed.
>

Sure I backed out the other patch - but you are right. It does magically work now
with your patch only. maybe  it was an interaction with the sound driver which hangs
on shutdown so maybe there where some transactions not written or replayed.

Thanks

Joachim
 
> I think. Put a printk before your goto out, and if it triggers
> then I am wrong.
> 
> What errors were you seeing with my patch? (If you applied my patch
> to an -mm kernel without first backing out the others then it will
> break).


_______________________________________________________________
SMS schreiben mit WEB.DE FreeMail - einfach, schnell und
kostenguenstig. Jetzt gleich testen! http://f.web.de/?mc=021192

