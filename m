Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265067AbTFYUjF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265070AbTFYUjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:39:05 -0400
Received: from ns.suse.de ([213.95.15.193]:3343 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265067AbTFYUjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:39:01 -0400
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] ACPI_HT_ONLY acpismp=force
References: <Pine.LNX.4.44.0306252112180.1636-100000@localhost.localdomain.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 25 Jun 2003 22:53:08 +0200
In-Reply-To: <Pine.LNX.4.44.0306252112180.1636-100000@localhost.localdomain.suse.lists.linux.kernel>
Message-ID: <p73isqt516z.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> writes:

> What's the point of bootparam "acpismp=force"?  A way to change
> your mind if you just said "acpi=off"?  A hurdle to jump to get
> CONFIG_ACPI_HT_ONLY to do what you ask?  2.4.18 used to need it to
> enable HT, but not recent releases.  It can't configure in what's
> not there, and now serves only to confuse: kill it.

There are some boxes that don't work with the new ACPI code, but need
minimal acpi parsing for hyperthreaded CPUs etc.

To get these still to work the compatibility option is offered.

Basically it's another safety net. Of course it would be better
to make new ACPI work everywhere, but it's quite difficult.
For 2.4 it's better to have the fallback.

-Andi
