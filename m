Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272855AbTHKQzJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272796AbTHKQw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:52:28 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:14011 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S272818AbTHKQvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:51:12 -0400
Date: Mon, 11 Aug 2003 17:52:44 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Len Brown <lenb417@yahoo.com>
cc: Florian Weimer <fw@deneb.enyo.de>, Andy Grover <andrew.grover@intel.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test3] Hyperthreading gone
In-Reply-To: <87oeyyc7u9.fsf@deneb.enyo.de>
Message-ID: <Pine.LNX.4.44.0308111734490.1365-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

On Sun, 10 Aug 2003, Florian Weimer wrote:
> Greg Norris <haphazard@kc.rr.com> writes:
> 
> > Did you select CPU Enumeration Only, or "normal" ACPI?
> 
> CPU Enumeration Only.
> 
> > If the former, did you specify the "acpismp=force" parameter at
> > bootup?
> 
> I didn't.  Previous experience (with some 2.5.x versions) indicates
> that Linux does not support full ACPI on this machine.  The
> documentation suggests that the command line option enables full ACPI,
> so I hesitate to do this.

Florian, at the moment, in 2.4 and in 2.6, you do have to specify the
"acpismp=force" boot parameter to get HT to work with CPU Enumeration
Only: it can't enable full ACPI since you don't have full ACPI built in,
so no need to hesitate.  But of course it's stupid, and the ACPI guys
agree it's wrong and to be fixed.

Len, what's up with this?  I'm not worried about 2.6 right now, but
4 weeks ago you were about to submit a patch to fix this for 2.4.22,
which is now at 2.4.22-rc2 and still behaving as broken in -pre1.

Is it time to dig out my own patch and send to Marcelo again?

Hugh

