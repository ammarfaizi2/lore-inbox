Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVBFNAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVBFNAQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVBFNAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:00:16 -0500
Received: from canuck.infradead.org ([205.233.218.70]:55045 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261205AbVBFNAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:00:11 -0500
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, drepper@redhat.com
In-Reply-To: <20050206125002.GF30109@wotan.suse.de>
References: <20050206113635.GA30109@wotan.suse.de>
	 <20050206114758.GA8437@infradead.org> <20050206120244.GA28061@elte.hu>
	 <20050206124523.GA762@elte.hu>  <20050206125002.GF30109@wotan.suse.de>
Content-Type: text/plain
Date: Sun, 06 Feb 2005 13:59:59 +0100
Message-Id: <1107694800.22680.90.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-06 at 13:50 +0100, Andi Kleen wrote:
> > i.e. all mappings are executable (i.e. READ_IMPLIES_EXEC effect) - the
> > intended change. (although i dont fully agree with PT_GNU_STACK being
> > about something else than the stack, from a security POV if the stack is
> > executable then all bets are off anyway. The heap and all mmaps being
> > executable too in that case makes little difference.)
> 
> Well, that won't fix mono

correct,
http://lists.ximian.com/archives/public/mono-list/2004-June/021592.html

that fixes mono instead

>  (and i suspect wine) and the others

wine is ok, it uses PROT_EXEC correctly for things it's not sure about.


