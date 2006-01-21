Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWAUACN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWAUACN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWAUACN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:02:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43729 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750804AbWAUACL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:02:11 -0500
Date: Sat, 21 Jan 2006 01:01:42 +0100
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Heinz Mauelshagen <mauelshagen@redhat.com>, Neil Brown <neilb@suse.de>,
       Phillip Susi <psusi@cfl.rr.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060121000142.GR2801@redhat.com>
Reply-To: mauelshagen@redhat.com
References: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com> <Pine.LNX.4.61.0601181427090.19392@yvahk01.tjqt.qr> <17358.52476.290687.858954@cse.unsw.edu.au> <43D00FFA.1040401@cfl.rr.com> <17360.5011.975665.371008@cse.unsw.edu.au> <43D02033.4070008@cfl.rr.com> <17360.9233.215291.380922@cse.unsw.edu.au> <20060120183621.GA2799@redhat.com> <20060120225724.GW22163@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060120225724.GW22163@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 11:57:24PM +0100, Lars Marowsky-Bree wrote:
> On 2006-01-20T19:36:21, Heinz Mauelshagen <mauelshagen@redhat.com> wrote:
> 
> > > Then 'dmraid' (or a similar tool) can use 'dm' interfaces for some
> > > raid levels and 'md' interfaces for others.
> > Yes, that's possible but there's recommendations to have a native target
> > for dm to do RAID5, so I started to implement it.
> 
> Can you answer me what the recommendations are based on?

Partner requests.

> 
> I understand wanting to manage both via the same framework, but
> duplicating the code is just ... wrong.
> 
> What's gained by it?
>
> Why not provide a dm-md wrapper which could then
> load/interface to all md personalities?
> 

As we want to enrich the mapping flexibility (ie, multi-segment fine grained
mappings) of dm by adding targets as we go, a certain degree and transitional
existence of duplicate code is the price to gain that flexibility.

> 
> Sincerely,
>     Lars Marowsky-Brée
> 
> -- 
> High Availability & Clustering
> SUSE Labs, Research and Development
> SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
> "Ignorance more frequently begets confidence than does knowledge"

Warm regards,
Heinz    -- The LVM Guy --

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat GmbH
Consulting Development Engineer                   Am Sonnenhang 11
Cluster and Storage Development                   56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
