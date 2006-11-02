Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752779AbWKBJu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbWKBJu0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 04:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbWKBJuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 04:50:25 -0500
Received: from holoclan.de ([62.75.158.126]:4520 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1752779AbWKBJuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 04:50:23 -0500
Date: Thu, 2 Nov 2006 10:48:50 +0100
From: Martin Lorenz <martin@lorenz.eu.org>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc3: more DWARFs and strange messages
Message-ID: <20061102094850.GC6299@gimli>
Mail-Followup-To: Jan Beulich <jbeulich@novell.com>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20061028200151.GC5619@gimli> <20061031160815.GM27390@gimli> <454787AB.76E4.0078.0@novell.com> <200610311828.52980.ak@suse.de> <20061101152746.GD6438@gimli> <4549CA86.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4549CA86.76E4.0078.0@novell.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Thu, Nov 02, 2006 at 09:37:58AM +0000, Jan Beulich
	wrote: > >what is a reasonable kstack parameter to be informative for
	you? > > This unfortunately depends on the depth of the stack that is in
	use > at the point the dump is taken. The only safe value would be to >
	dump the full stack size (kstack=1024 for 4k stack, kstack=2048 > for 8k
	ones), but since it'll stop at a stack boundary perhaps that's > what
	you should go with. > > As to Andi's remark regarding WARN_ON() - you'd
	have to address > that issue in a private patch first, or the addition
	of the kstack= > parameter will be useless. I presume it's likely you
	don't have the > time to do that... [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 09:37:58AM +0000, Jan Beulich wrote:
> >what is a reasonable kstack parameter to be informative for you?
> 
> This unfortunately depends on the depth of the stack that is in use
> at the point the dump is taken. The only safe value would be to
> dump the full stack size (kstack=1024 for 4k stack, kstack=2048
> for 8k ones), but since it'll stop at a stack boundary perhaps that's
> what you should go with.
> 
> As to Andi's remark regarding WARN_ON() - you'd have to address
> that issue in a private patch first, or the addition of the kstack=
> parameter will be useless. I presume it's likely you don't have the
> time to do that...

well...
to be honest, I need my computer to work during usual daily business
at the moment I can afford to do a compile and test a new kernel once a day,
but if it introduces instabilities that make my computer unusable for
productive work (which means programming, running heavy java applications
and  and TeXing) I can't run it for more than a few minutes.

I started a bisection last weekend but had to give up after three
compile-reboot cycles.

so, please don't expect too much, but I will do my best to help

gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
