Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVCWRY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVCWRY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVCWRWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:22:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37013 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261679AbVCWRR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:17:29 -0500
Date: Wed, 23 Mar 2005 12:17:23 -0500
From: Dave Jones <davej@redhat.com>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Message-ID: <20050323171723.GA9663@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Giuseppe Bilotta <bilotta78@hotpop.com>,
	linux-kernel@vger.kernel.org
References: <20050314083717.GA19337@elf.ucw.cz> <200503140855.18446.jbarnes@engr.sgi.com> <20050314191230.3eb09c37.diegocg@gmail.com> <1110827273.14842.3.camel@mindpipe> <20050323013729.0f5cd319.diegocg@gmail.com> <1111539217.4691.57.camel@mindpipe> <20050323011313.GL15879@redhat.com> <MPG.1cab456fb7b20f93989718@news.gmane.org> <20050323161441.GA7994@redhat.com> <MPG.1cabbc978b50163989719@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MPG.1cabbc978b50163989719@news.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 05:49:47PM +0100, Giuseppe Bilotta wrote:
 > > > What are the cons of using "all of" the RAM at boot time to 
 > > > cache the boot disk?
 > 
 > Dave Jones wrote:
 > > It's memory that's otherwise unused. Once you start using the system
 > > anything cached will get reclaimed as its needed.
 > 
 > So there is no substantial loss? IOW, it would suffice to have 
 > all the "loaded at boot" stuff in the first <amount of RAM>
 > bytes of the hard disk?

It very likely also needs to be contiguous on-disk (Ie, no in-file
fragmentation). You want to limit the amount of seeking that gets
done so the drive readahead just performs continuous reads.

		Dave

