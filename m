Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWAUAOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWAUAOE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWAUAOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:14:04 -0500
Received: from gate.in-addr.de ([212.8.193.158]:14223 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S932293AbWAUAOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:14:02 -0500
Date: Sat, 21 Jan 2006 01:13:11 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Heinz Mauelshagen <mauelshagen@redhat.com>
Cc: Neil Brown <neilb@suse.de>, Phillip Susi <psusi@cfl.rr.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060121001311.GA22163@marowsky-bree.de>
References: <17358.52476.290687.858954@cse.unsw.edu.au> <43D00FFA.1040401@cfl.rr.com> <17360.5011.975665.371008@cse.unsw.edu.au> <43D02033.4070008@cfl.rr.com> <17360.9233.215291.380922@cse.unsw.edu.au> <20060120183621.GA2799@redhat.com> <20060120225724.GW22163@marowsky-bree.de> <20060121000142.GR2801@redhat.com> <20060121000344.GY22163@marowsky-bree.de> <20060121000806.GT2801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060121000806.GT2801@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-01-21T01:08:06, Heinz Mauelshagen <mauelshagen@redhat.com> wrote:

> > A dm-md wrapper would give you the same?
> No, we'ld need to stack more complex to achieve mappings.
> Think lvm2 and logical volume level raid5.

How would you not get that if you had a wrapper around md which made it
into an dm personality/target?

Besides, stacking between dm devices so far (ie, if I look how kpartx
does it, or LVM2 on top of MPIO etc, which works just fine) is via the
block device layer anyway - and nothing stops you from putting md on top
of LVM2 LVs either.

I use the regularly to play with md and other stuff...

So I remain unconvinced that code duplication is worth it for more than
"hark we want it so!" ;-)



