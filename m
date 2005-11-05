Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbVKERkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbVKERkO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 12:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVKERkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 12:40:14 -0500
Received: from cantor.suse.de ([195.135.220.2]:23734 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750925AbVKERkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 12:40:12 -0500
To: Zachary Amsden <zach@vmware.com>
Cc: linux-kernel@vger.kernel.org, macro@linux-mips.org
Subject: Re: 2.6.14: CR4 not needed to be inspected on the 486 anymore?
References: <Pine.LNX.4.55.0511031600010.24109@blysk.ds.pg.gda.pl>
	<436A3C10.9050302@vmware.com>
	<Pine.LNX.4.55.0511031639310.24109@blysk.ds.pg.gda.pl>
	<436AA1FD.3010401@vmware.com>
From: Andi Kleen <ak@suse.de>
Date: 05 Nov 2005 18:40:10 +0100
In-Reply-To: <436AA1FD.3010401@vmware.com>
Message-ID: <p73fyqb2dtx.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden <zach@vmware.com> writes:
 > 
> He won't like me too much. I'll write up a proper patch for this, a la
> mode de rdmsr_safe / wrmsr_safe. At least it's not a bug, just missing
> information.

I don't think it's a good idea. Relying on nested faults in oops
is a bit unsafe because it could lead to recursive faults in the worst case. 
Yes it does it already with __get_user, but that
is only last resort. You would make it default on these systems.

Better keep the if

-Andi
