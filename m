Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290814AbSBLHnp>; Tue, 12 Feb 2002 02:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290815AbSBLHnf>; Tue, 12 Feb 2002 02:43:35 -0500
Received: from coruscant.franken.de ([193.174.159.226]:36503 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S290817AbSBLHnZ>; Tue, 12 Feb 2002 02:43:25 -0500
Date: Tue, 12 Feb 2002 08:36:26 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org,
        stelian.pop@fr.alcove.com, hpa@zytor.com
Subject: Re: [SOLUTION] Re: Fw: 2.4.18-pre9: iptables screwed?
Message-ID: <20020212083626.P11911@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
	netfilter-devel@lists.samba.org, stelian.pop@fr.alcove.com,
	hpa@zytor.com
In-Reply-To: <20020208105548.P26676@sunbeam.de.gnumonks.org> <Pine.LNX.3.96.1020211130712.32755C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.3.96.1020211130712.32755C-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Mon, Feb 11, 2002 at 01:11:51PM -0500
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Setting Orange, the 40th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 01:11:51PM -0500, Bill Davidsen wrote:
 
> What is the first thing anyone would do if they had a problem with
> iptables? Turn on debugging, obviously.

yes, I totally agree.  I'm not arguing that the current behaviour is OK - 
of course it should work with debugging enabled.  All I said is that under
normal circumstances a production system is not supposed to have debugging
enabled.

> 2 - it really should work, debug should find errors, not cause them.

of course. That is why debugging does extra checks, which are disabled 
in production use.  Unfortunately we missed one check...

> 3 - Perhaps debug could be disabled but default, so instead of needing
>     NDEBUG in production, you would use -DDEBUG when you had a problem
>     (and it might even work ;-).

Yes, this is what I'm doing for the iptables-1.2.6 release.  The current
-DNDEBUG stuff has historical reasons which are no longer valid.

> bill davidsen <davidsen@tmr.com>

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)
