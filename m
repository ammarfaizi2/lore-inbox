Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWDYHXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWDYHXw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 03:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWDYHXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 03:23:52 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:16139 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751367AbWDYHXv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 03:23:51 -0400
To: Valdis.Kletnieks@vt.edu
Cc: Lars Marowsky-Bree <lmb@suse.de>, Stephen Smalley <sds@tycho.nsa.gov>,
       Kyle Moffett <mrmacman_g4@mac.com>, casey@schaufler-ca.com,
       James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
References: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com>
	<CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com>
	<200604190656.k3J6uSGW010288@turing-police.cc.vt.edu>
	<32851499-DA27-46AF-A1A4-E668BBE0771D@mac.com>
	<1145536803.3313.32.camel@moss-spartans.epoch.ncsc.mil>
	<87y7xzu4hj.fsf@hades.wkstn.nix>
	<1145629477.21749.146.camel@moss-spartans.epoch.ncsc.mil>
	<20060424081433.GG440@marowsky-bree.de>
	<200604250019.k3P0JmJQ004798@turing-police.cc.vt.edu>
From: Nix <nix@esperi.org.uk>
X-Emacs: well, why *shouldn't* you pay property taxes on your editor?
Date: Tue, 25 Apr 2006 08:21:51 +0100
In-Reply-To: <200604250019.k3P0JmJQ004798@turing-police.cc.vt.edu> (Valdis Kletnieks's message of "Mon, 24 Apr 2006 20:19:47 -0400")
Message-ID: <87odyqnmr4.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2006, Valdis Kletnieks stated:
>> This is not correct, as far as I understand. As the app can only rename
>> in it has access to both the old and the new path.
> 
> People seem to have a blind spot for this sort of thing.  Given *two* processes,
> one of which can be convinced to do a rename, and another that can be convinced
> to write a file, you can subvert everything (quite possibly in opposite order -
> if you can get process A to write /etc/foobar, and process B to rename foobar
> to passwd, you've won).

If those processes are exposed enough that external attackers can talk
to them at all, they should be confined. And anyone who allows confined
processes to write to /etc or create or rename links in /etc at all is
an idiot.

Are we *really* defending against people who write blatantly idiotic
profiles? (What's more, unlike with SELinux, it's guaranteed to be easy
to see that that profile is idiotic, because the policy language is so
simple.)

(Obviously creating or renaming links in /** is every bit as
bad. Don't-write-stupid-profiles rule again.)

(I'm assuming a post-chroot()-absolute-paths world: in the previous
world, as exemplified by the current example profiles, /** is sane *if
and only if* the confined app is always chrooted.)

-- 
`On a scale of 1-10, X's "brokenness rating" is 1.1, but that's only
 because bringing Windows into the picture rescaled "brokenness" by
 a factor of 10.' --- Peter da Silva
