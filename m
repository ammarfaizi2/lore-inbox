Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265717AbSKFPlj>; Wed, 6 Nov 2002 10:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265726AbSKFPlj>; Wed, 6 Nov 2002 10:41:39 -0500
Received: from mg01.austin.ibm.com ([192.35.232.18]:49600 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S265717AbSKFPli>; Wed, 6 Nov 2002 10:41:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Lars Marowsky-Bree <lmb@suse.de>, evms-devel@lists.sourceforge.net
Subject: Re: EVMS announcement
Date: Wed, 6 Nov 2002 09:08:43 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <02110516191004.07074@boiler> <20021106001607.GJ27832@marowsky-bree.de>
In-Reply-To: <20021106001607.GJ27832@marowsky-bree.de>
MIME-Version: 1.0
Message-Id: <02110609084300.06245@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 November 2002 18:16, Lars Marowsky-Bree wrote:
> Now, an interesting question is whether the md modules etc will simply be
> continued to be used or whether they'll make use of the DM engine too? Can
> they be made "plugins" to DM or the EVMS framework?

I think the MD kernel modules certainly *could* be ported to the dev-mapper 
framework. But right now, from EVMS's standpoint, there is no need to force 
that change just yet. If it is determined in the future that that would be a 
better direction to go, for us it would just mean re-coding the user-space MD 
plugin to talk to dev-mapper instead of the MD driver. But a lot of work has 
gone into the MD driver during 2.5, so I would personally think such a change 
won't happen until at least 2.7.

> Or even, could EVMS (in
> theory) parse the meta-data from a legacy md device and just setup a DM
> mapping for it? That would appeal to me quite a bit. I really need to start
> reading up on it...

The pretty much exactly what does/will happen, except EVMS will talk to the 
MD driver now (maybe DM in the future).

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
