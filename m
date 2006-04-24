Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWDXPyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWDXPyd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWDXPyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:54:33 -0400
Received: from cantor2.suse.de ([195.135.220.15]:16562 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750852AbWDXPyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:54:32 -0400
Date: Mon, 24 Apr 2006 08:50:03 -0700
From: Tony Jones <tonyj@suse.de>
To: Joshua Brindle <method@gentoo.org>
Cc: Andi Kleen <ak@suse.de>, Neil Brown <neilb@suse.de>,
       Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060424155003.GC25238@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <17484.20906.122444.964025@cse.unsw.edu.au> <444CCE83.90704@gentoo.org> <200604241526.03127.ak@suse.de> <444CD507.70004@gentoo.org> <444CEBC9.5030802@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444CEBC9.5030802@gentoo.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 11:16:25AM -0400, Joshua Brindle wrote:
> To make this much more real, the /usr/sbin/named policy that ships with 
> apparmor has the following line:

Ships with AppArmor where?  On SuSE?

> /** r,
> Thats right, named can read any file on the system, I suppose this is 
> because the policy relies on named being chrooted. So if for any reason 
> named doesn't chroot its been granted read access on the entire 
> filesystem. If I'm misunderstanding this policy please correct me but I 
> believe this shows the problem very loudly and clearly.

The d_path changes for absolute path mediation for chroot are not yet in any 
SuSE release. Nor are they reflected in any developed profiles (yet).

Another direction is a new security_chroot hook together with appropriate 
CLONE_FS tracking (inside AppArmor) to force chrooting confined tasks into a 
subprofile (similar to change hat). We are evaluating the options based on 
feedback here and from other places.  Hence the RFC.

I hope this helps.

Tony
