Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWDUBB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWDUBB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 21:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWDUBB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 21:01:58 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:28941 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932194AbWDUBB5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 21:01:57 -0400
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       casey@schaufler-ca.com, James Morris <jmorris@namei.org>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
References: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com>
	<CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com>
	<200604190656.k3J6uSGW010288@turing-police.cc.vt.edu>
	<32851499-DA27-46AF-A1A4-E668BBE0771D@mac.com>
	<1145536803.3313.32.camel@moss-spartans.epoch.ncsc.mil>
From: Nix <nix@esperi.org.uk>
X-Emacs: featuring the world's first municipal garbage collector!
Date: Fri, 21 Apr 2006 02:00:56 +0100
In-Reply-To: <1145536803.3313.32.camel@moss-spartans.epoch.ncsc.mil> (Stephen Smalley's message of "20 Apr 2006 14:36:06 +0100")
Message-ID: <87y7xzu4hj.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Apr 2006, Stephen Smalley yowled:
> - Approved tools/libraries are instrumented to specify the desired label
> for passwd vs. shadow (and backup files), since the same code re-creates
> both on a transaction (at least when adding/removing users), so the
> kernel can't make that distinction automatically; only the tool knows
> that.  This is consistent with how DAC mode is handled for passwd vs.
> shadow. 

So... every program which may modify labelled entities (e.g., for files,
by unlink()/creat()) needs modification for SELinux?

This strikes me as rather impractical if you want to be able to label
files that users may edit: there are a lot of programs users run that
`modify' files in that way. For starters, every web browser, every text
editor...  is it really sensible to require modification of *almost
everything* that can overwrite files lest you magically lose labels that
you thought you had?

(With AppArmor, of course, you never lose labels at all, because there
aren't any.)

(I may be missing something, but I know that when I've tried to use
SELinux to constrain what such programs could manipulate, I was
losing labels to unlink()/creat() left right and centre.)

-- 
`On a scale of 1-10, X's "brokenness rating" is 1.1, but that's only
 because bringing Windows into the picture rescaled "brokenness" by
 a factor of 10.' --- Peter da Silva
