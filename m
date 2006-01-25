Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWAYUdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWAYUdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWAYUdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:33:38 -0500
Received: from mx.pathscale.com ([64.160.42.68]:12526 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751215AbWAYUdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:33:37 -0500
Subject: RE: [perfmon] Re: quick overview of the perfmon2 interface
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: "Truong, Dan" <dan.truong@hp.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "Eranian, Stephane" <stephane.eranian@hp.com>,
       perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
In-Reply-To: <3C87FFF91369A242B9C9147F8BD0908A02C6955C@cacexc04.americas.cpqcorp.net>
References: <3C87FFF91369A242B9C9147F8BD0908A02C6955C@cacexc04.americas.cpqcorp.net>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 25 Jan 2006 12:33:32 -0800
Message-Id: <1138221212.15295.35.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 10:37 -0800, Truong, Dan wrote:
> Would you want Stephane to guard the extended
> functionalities with tunables or something to
> Disable their regular use and herd enterprise
> Tools into a standard mold... yet allow R&D to
> Move on by enabling the extentions?

I'd prefer to see all of the extended stuff left out entirely for now.
The mainline kernel has no PMU support for any popular architecture,
even though external patches have existed in stable form for years.
Filling that gap ought to be the priority; the interface can be extended
when actual users of new features show up and ask for them.

> It would restrict the R&D mindset, and new ideas.
> The field hasn't grown yet to a stable mature form.

The place for flailing around with uncooked ideas is arguably not the
mainline kernel.

> Flexibility is/was needed because:
> - Tools need to port to Perfmon with min cost.
> - Ability to support novel R&D ideas.
> - Ability to support growth beyond just PMU data
> - Allows early data aggregation
> - Allow OS data correlated to PMU

Speculatively adding complicated and unused interfaces to the kernel in
the hope that some wild-eyed visionary might eventually up and use them
helps nobody.

	<b

