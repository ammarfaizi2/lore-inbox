Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWAWKkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWAWKkV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 05:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWAWKkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 05:40:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45758 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932448AbWAWKkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 05:40:19 -0500
Date: Mon, 23 Jan 2006 11:38:51 +0100
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Heinz Mauelshagen <mauelshagen@redhat.com>, Neil Brown <neilb@suse.de>,
       Phillip Susi <psusi@cfl.rr.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060123103851.GY2801@redhat.com>
Reply-To: mauelshagen@redhat.com
References: <43D02033.4070008@cfl.rr.com> <17360.9233.215291.380922@cse.unsw.edu.au> <20060120183621.GA2799@redhat.com> <20060120225724.GW22163@marowsky-bree.de> <20060121000142.GR2801@redhat.com> <20060121000344.GY22163@marowsky-bree.de> <20060121000806.GT2801@redhat.com> <20060121001311.GA22163@marowsky-bree.de> <20060123094418.GX2801@redhat.com> <20060123102601.GD2366@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060123102601.GD2366@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 11:26:01AM +0100, Lars Marowsky-Bree wrote:
> On 2006-01-23T10:44:18, Heinz Mauelshagen <mauelshagen@redhat.com> wrote:
> 
> > > Besides, stacking between dm devices so far (ie, if I look how kpartx
> > > does it, or LVM2 on top of MPIO etc, which works just fine) is via the
> > > block device layer anyway - and nothing stops you from putting md on top
> > > of LVM2 LVs either.
> > > 
> > > I use the regularly to play with md and other stuff...
> > 
> > Me too but for production, I want to avoid the
> > additional stacking overhead and complexity.
> 
> Ok, I still didn't get that. I must be slow.
> 
> Did you implement some DM-internal stacking now to avoid the above
> mentioned complexity? 
> 
> Otherwise, even DM-on-DM is still stacked via the block device
> abstraction...

No, not necessary because a single-level raid4/5 mapping will do it.
Ie. it supports <offset> parameters in the constructor as other targets
do as well (eg. mirror or linear).

> 
> 
> Sincerely,
>     Lars Marowsky-Brée
> 
> -- 
> High Availability & Clustering
> SUSE Labs, Research and Development
> SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
> "Ignorance more frequently begets confidence than does knowledge"

-- 

Regards,
Heinz    -- The LVM Guy --

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat GmbH
Consulting Development Engineer                   Am Sonnenhang 11
Cluster and Storage Development                   56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
