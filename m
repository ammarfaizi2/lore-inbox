Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932854AbWFMEEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932854AbWFMEEE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 00:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbWFMEEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 00:04:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:10387 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932854AbWFMEED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 00:04:03 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: broken local_t on i386
Date: Tue, 13 Jun 2006 06:02:59 +0200
User-Agent: KMail/1.9.3
Cc: Christoph Lameter <clameter@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060609214024.2f7dd72c.akpm@osdl.org> <200606122011.52841.ak@suse.de> <1150143161.25462.26.camel@localhost.localdomain>
In-Reply-To: <1150143161.25462.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606130602.59504.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 22:12, Alan Cox wrote:
> Ar Llu, 2006-06-12 am 20:11 +0200, ysgrifennodd Andi Kleen:
> > The segment register needs an offset. So you need the linker to generate
> > the offset from the base of the per cpu segment somehow. At compile time the 
> > address is not known so it cannot be done then.
> 
> What happens if you put a section at zero and a section at non-fixed
> address (aligned). In the asm macros you stick the variable in both,
> using the zero based one for linker symbols and the non zero based one
> for data, then discard the zero based one.

Interesting idea.  Maybe it'll work.
 
> That used to work for old binutils which didn't care/spot if you were
> discarding material you actually linked against. Not sure what todays
> binutils does with it.

AFAIK it warns at least. Might get noisy.

-Andi
