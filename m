Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWAFBBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWAFBBq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWAFBBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:01:46 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:6104 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932364AbWAFBBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:01:45 -0500
Date: Fri, 6 Jan 2006 01:58:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Matt Mackall <mpm@selenic.com>, Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
Message-ID: <20060106005839.GA24899@elte.hu>
References: <43BC716A.5080204@mbligh.org> <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org> <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <43BD784F.4040804@mbligh.org> <Pine.LNX.4.64.0601051208510.3169@g5.osdl.org> <Pine.LNX.4.64.0601051213270.3169@g5.osdl.org> <20060106005004.GC84622@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106005004.GC84622@gaz.sfgoth.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mitchell Blank Jr <mitch@sfgoth.com> wrote:

> I actually did that in a project once (an "unlikely_if()" macro) It 
> was not a good idea.  The problem is that every syntax-highlighter 
> knows that "if" is a keyword but you'd have to teach it about 
> "unlikely_if".  It was surprising how visually jarring having 
> different pretty-printing for different types of "if" statements was.  
> "if (unlikely())" looks much cleaner in comparison.

a better syntax would be:

	if __unlikely (cond) {
		...
	}

since it's the extra parantheses that are causing the visual complexity.

	Ingo
