Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTLIXqT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 18:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTLIXqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 18:46:19 -0500
Received: from hibernia.jakma.org ([213.79.33.168]:6302 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S263435AbTLIXqR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 18:46:17 -0500
Date: Tue, 9 Dec 2003 23:46:13 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Joe Thornber <thornber@sistina.com>, linux-kernel@vger.kernel.org
Subject: Re: Device-mapper submission for 2.4
In-Reply-To: <Pine.LNX.4.44.0312092047450.1289-100000@logos.cnet>
Message-ID: <Pine.LNX.4.56.0312092329280.30298@fogarty.jakma.org>
References: <Pine.LNX.4.44.0312092047450.1289-100000@logos.cnet>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Marcelo Tosatti wrote:

> Its nothing against your or DM itself.
> 
> Let DM be in 2.6. 

Well, how does this leave 2.4 LVM1 users? From my vague 
understanding:

- 2.6 DM does not support the LVM1 interface
- The DM tools library is dropping support for the LVM1 interface

This leaves 2.4 LVM1 users with a /huge/ leap to take if they wish to
test 2.6. Backward compatibility is awkward because of the DM tools
issue (need both old and new installed and some way to pick at boot,
or manually setup LVM), and you're ruling out the other option of
adding forwards compatibility to 2.4.

This isnt a new fs which 2.4 users wont be using, its an existing 
feature that has been reworked during 2.5 and is now incompatible in 
2.6 with 2.4. More over, its a feature on which access to data 
depends.

I'd really like to see one of:

- backwards compat: 2.6 have LVM1 support

- forward compat: 2.4 to have DM support to allow 2.4 users to 
migrate
LVM->DM first /before/ taking the risk on running 2.6.

- the DM tools to support both LVM1 and LVMx in 2.6, on a *long-term* 
  basis

I or others may not migrate to 2.6 for many a year, and when we do,
it'd nice to be able to migrate our data in place (not
backup&restore). Kernel interface compat at least tends to be the
most set in stone and is what I would prefer. Whether forward or
backward doesnt matter, adding compat cruft to a soon-to-be obsolete 
kernel is possibly better than weighing 2.6 down with it for the next 
3+ years.

There are people who store their data in LVM, we need compatibility,
and ideally we'd like to be able to migrate in small steps.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
You can write a small letter to Grandma in the filename.
		-- Forbes Burkowski, CS, University of Washington
