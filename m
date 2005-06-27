Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVF0EWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVF0EWO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 00:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVF0EWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 00:22:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37029 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261799AbVF0EWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 00:22:10 -0400
Date: Sun, 26 Jun 2005 21:24:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
cc: Pavel Machek <pavel@ucw.cz>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, raybry@engr.sgi.com
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing usable
 for other purposes
In-Reply-To: <Pine.LNX.4.62.0506261928010.1679@graphe.net>
Message-ID: <Pine.LNX.4.58.0506262121070.19755@ppc970.osdl.org>
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net>
 <20050625025122.GC22393@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506242311220.7971@graphe.net>
 <20050626023053.GA2871@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506251954470.26198@graphe.net>
 <20050626030925.GA4156@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506261928010.1679@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 Jun 2005, Christoph Lameter wrote:
> 
> 3. I wish there would be a better way to handle the PF_FREEZE. Its like a 
> signal delivery after all. Is there any way to define an in kernel signal? 
> Or a way to make a process execute a certain bit of code?

It's called "work", and we have the "TIF_xxx" flags for it. That's how 
"need-resched" and "sigpending" are done. There could be a 
"TIF_FREEZEPENDING" thing there too..

		Linus
