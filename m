Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWDSR5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWDSR5U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWDSR5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:57:19 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:17117 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751080AbWDSR5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:57:17 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
In-Reply-To: <20060419164217.53082.qmail@web36605.mail.mud.yahoo.com>
References: <20060419164217.53082.qmail@web36605.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 19 Apr 2006 14:01:10 -0400
Message-Id: <1145469670.24289.206.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 09:42 -0700, Casey Schaufler wrote:
> 
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > This would be fine, if the technical approach were
> > sound (not necessarily the same as SELinux, but
> sound)
> 
> Please accept that this is a judgement call.

Judgment calls have to be made all the time; this is no different.  One
would hope that particularly in the arena of security, sound judgment
would be applied.  In this particular case, it isn't just security folks
who are troubled by reliance on pathnames, and there are plenty of prior
discussions on linux-fsdevel and linux-kernel describing the brokenness
of path-based approaches.  Why would the answer be different now?

> > and fit properly with the LSM interface.
> 
> Of course LSM will fit SELinux better than it fits
> AppArmour, LSM has been adapted to fit the needs
> of SELinux. 

This is a gross misrepresentation of the facts and history of LSM.  LSM
was jointly developed, and the initial VFS inode hooks were proposed by
none other than the WireX folks, i.e. the developers of
SubDomain/AppArmor.  From that initial proposal, though the entire
development of LSM, through the 2.5 development series after LSM was
merged, and through the 2.6 stable series so far, no one from the
AppArmor side has ever suggested a need to change the hooks to better
accomodate their needs.  Yet if you look at their implementation (and I
have, have you?), you'll see that they have to go through contortions
because the LSM interface is such a mismatch for what they do.  That
isn't due to any "adaptations" for SELinux.

> SELinux wasn't always a good fit either. LSM
> accomodated SELinux. Offer the same community
> cooperation to other you have yourself received.

Community cooperation doesn't mean embracing unsound ideas.

-- 
Stephen Smalley
National Security Agency

