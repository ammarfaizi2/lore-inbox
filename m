Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030475AbWJCSk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbWJCSk6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbWJCSk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:40:58 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:16894 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S964862AbWJCSk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:40:57 -0400
Date: Tue, 3 Oct 2006 11:38:49 -0700
To: Jeff Garzik <jeff@garzik.org>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003183849.GA17635@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4522A9BE.9000805@garzik.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 02:19:42PM -0400, Jeff Garzik wrote:
> John W. Linville wrote:
> >The more we can clean-up the WE API, the easier it will be to implement
> >the cfg80211 WE compatibility layer intended for wireless-dev.
> >I think WE-21 makes things better in that respect.
> >
> >Finally, I already scaled-back Jean's original WE-21 patch.  I only
> >anticipate minor bug fixes for WE from now on, with nl80211/cfg80211
> >as the heir-apparent.
> >
> >With all that said, I'd prefer to keep the existing WE-21 patches and
> >add Jean's fixes ASAP.  Is this acceptable?  If not, I'll submit the
> >reversions to Jeff ASAP.
> 
> I for one don't want to change the userspace ABI for this...  If I had 
> realized the userspace ABI was changing (<- my fault), I wouldn't have 
> merged the changes in the first place.
> 
> 	Jeff

	Jeff,

	This was discussed publically on this mailing list last
January.
		http://marc.theaimsgroup.com/?t=113710086000009&r=1&w=2
	I made clear at that time that I did not like this change
because the userspace ABI would change, but I was overruled by a wide
consensus. So, don't blame me.
	This change was rediscussed and reconfirmed at the Wireless
Summit. I only tried to make such change smooth, but it was not my
idea.

	Now it's too late, those changes have propagated to userspace
tools, and are now shipping in some actual release of some distro. So,
what are we going to say to Mandriva 2007 and FC6 users, to revert
back to an *older* version of the tools ?
	Because userspace has already been updated, we have only two
options, merge it now, or in 2.6.20.

	Regards,

	Jean

