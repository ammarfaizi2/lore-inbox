Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbWEUWiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbWEUWiP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 18:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWEUWiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 18:38:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:30897 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751493AbWEUWiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 18:38:14 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: IA32 syscall 311 not implemented on x86_64
Date: Mon, 22 May 2006 00:37:57 +0200
User-Agent: KMail/1.9.1
Cc: Ulrich Drepper <drepper@gmail.com>, Chris Wedgwood <cw@f00f.org>,
       dragoran <dragoran@feuerpokemon.de>, linux-kernel@vger.kernel.org
References: <44702650.30507@feuerpokemon.de> <200605220019.08902.ak@suse.de> <20060521222831.GP8250@redhat.com>
In-Reply-To: <20060521222831.GP8250@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605220037.58286.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 May 2006 00:28, Dave Jones wrote:
> On Mon, May 22, 2006 at 12:19:08AM +0200, Andi Kleen wrote:
> 
>  > >  > You make a good point.  In fact, given it's unthrottled, someone
>  > >  > with too much time on their hands could easily fill up a /var
>  > >  > just by calling unimplemented syscalls this way.
>  > 
>  > I never bought this argument because there are tons of printks in the kernel
>  > that can be triggered by everybody.
> 
> Then they should also be either rate limited, or removed.

Yes let's remove all that kernel debugging support. It is totally useless
for most users, isn't it?

Even if they are ratelimit you can still fill up /var.

> 
>  > > Actually it is kinda throttled, but only on process name.
>  > > This patch just removes that stuff completely.
>  > > (Also removes a bunch of trailing whitespace)
>  > 
>  > FF tree already has a different solution.
> 
> Adding a sysctl ? That seems way overkill to me.
> What practical purpose does that printk solve ?

Catching missing code in the compat layer.

-Andi
