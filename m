Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265112AbTFYWOO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 18:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbTFYWOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 18:14:14 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:54315 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S265112AbTFYWOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 18:14:10 -0400
Date: Wed, 25 Jun 2003 23:29:41 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] ACPI_HT_ONLY acpismp=force
In-Reply-To: <p73isqt516z.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0306252321250.1138-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jun 2003, Andi Kleen wrote:
> Hugh Dickins <hugh@veritas.com> writes:
> 
> > What's the point of bootparam "acpismp=force"?  A way to change
> > your mind if you just said "acpi=off"?  A hurdle to jump to get
> > CONFIG_ACPI_HT_ONLY to do what you ask?  2.4.18 used to need it to
> > enable HT, but not recent releases.  It can't configure in what's
> > not there, and now serves only to confuse: kill it.
> 
> There are some boxes that don't work with the new ACPI code, but need
> minimal acpi parsing for hyperthreaded CPUs etc.
> 
> To get these still to work the compatibility option is offered.
> 
> Basically it's another safety net. Of course it would be better
> to make new ACPI work everywhere, but it's quite difficult.
> For 2.4 it's better to have the fallback.

Sure, I don't contest that.  The patch isn't removing that fallback,
it's removing the need to say "acpismp=force" to get the fallback to
do anything at all - why demand both a config option and a bootparam?

And if there are yet others which go wrong with that fallback,
it allows "acpi=off" to boot on those too.

Whether that compatibility code should now be subject to this new
config option is questionable; but I don't propose to change that.

Hugh

