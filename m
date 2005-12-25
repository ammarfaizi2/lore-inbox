Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVLYKRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVLYKRf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 05:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVLYKRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 05:17:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45993 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750769AbVLYKRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 05:17:34 -0500
Subject: Re: FS possible security exposure ?
From: Arjan van de Ven <arjan@infradead.org>
To: regatta <regatta@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5a3ed5650512250210w3528a8ccsb4df2c3a23863c40@mail.gmail.com>
References: <5a3ed5650512250129t434d2b42kc1ebac1c5b308986@mail.gmail.com>
	 <1135503601.2946.6.camel@laptopd505.fenrus.org>
	 <5a3ed5650512250210w3528a8ccsb4df2c3a23863c40@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 25 Dec 2005 11:17:32 +0100
Message-Id: <1135505852.2946.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-25 at 13:10 +0300, regatta wrote:
> I'm using Vi in Solaris and Vim in Linux, do you think this is the
> problem ?

that very well can be the difference

> but if you think about it, how could the system allow the user to
> modify a file that he don't own it and he don't have write privilege
> on the file just because he has write in the parent directory ?
> 
> Maybe I'm wrong, but is this normal ? please let me know

this is normal and a result of the linux permission model.
(and fwiw you don't get to edit the file, only to create a new file. You
may think that's exactly the same.. but it's not in the light of
hardlinks)

Btw there is a "sticky bit" you can set on the directory which changes this behavior,
for example /tmp has this set for obvious reasons

> BTW: is there any document, article or any page about this so I can
> show it to my boss :)

I suspect the SUS standard fully specifies the 4 rules I mentioned and
the sticky-exception (and the rest is an obvious result)


