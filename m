Return-Path: <linux-kernel-owner+w=401wt.eu-S1030181AbXAKBhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbXAKBhM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 20:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbXAKBhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 20:37:12 -0500
Received: from ns2.suse.de ([195.135.220.15]:39347 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030181AbXAKBhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 20:37:10 -0500
From: Andi Kleen <ak@suse.de>
To: Neil Brown <neilb@suse.de>
Subject: Re: PATCH - x86-64 signed-compare bug, was Re: select() setting ERESTARTNOHAND (514).
Date: Thu, 11 Jan 2007 02:37:05 +0100
User-Agent: KMail/1.9.5
Cc: Sean Reifschneider <jafo@tummy.com>, linux-kernel@vger.kernel.org
References: <20070110234238.GB10791@tummy.com> <200701110140.51842.ak@suse.de> <17829.36029.240912.274302@notabene.brown>
In-Reply-To: <17829.36029.240912.274302@notabene.brown>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701110237.05753.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 January 2007 02:02, Neil Brown wrote:
> On Thursday January 11, ak@suse.de wrote:
> > > Just a 'me too' at this point. 
> > > The X server on my shiny new notebook (Core 2 Duo) occasionally dies
> > > with 'select' repeatedly returning ERESTARTNOHAND.  It is most
> > > annoying!
> > 
> > Normally it should be only visible in strace. Did you see it without
> > strace?
> 
> No, only in strace.

strace leaks internal errors. At some point that should be fixed,
but it's not really a serious problem.

There was one other report of internal errors leaking without strace,
but it was vague and I never got confirmation.

> Still, I think it would be safer to have the cast, in case the compiler
> decided to be clever.... or does the C standard ensure against that?

It does.

-Andi
