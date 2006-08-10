Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161255AbWHJOYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161255AbWHJOYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbWHJOYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:24:32 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:45711 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161043AbWHJOYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:24:31 -0400
Date: Thu, 10 Aug 2006 16:24:25 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jeff Garzik <jeff@garzik.org>
cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
In-Reply-To: <44DB3D65.6030308@garzik.org>
Message-ID: <Pine.LNX.4.64.0608101620350.6761@scrub.home>
References: <1155172843.3161.81.camel@localhost.localdomain>
 <20060809234019.c8a730e3.akpm@osdl.org> <Pine.LNX.4.64.0608101302270.6762@scrub.home>
 <44DB203A.6050901@garzik.org> <Pine.LNX.4.64.0608101409350.6762@scrub.home>
 <44DB25C1.1020807@garzik.org> <Pine.LNX.4.64.0608101429510.6762@scrub.home>
 <44DB27A3.1040606@garzik.org> <Pine.LNX.4.64.0608101459260.6761@scrub.home>
 <44DB3151.8050904@garzik.org> <Pine.LNX.4.64.0608101519560.6762@scrub.home>
 <44DB34FF.4000303@garzik.org> <Pine.LNX.4.64.0608101547261.6761@scrub.home>
 <44DB3D65.6030308@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Aug 2006, Jeff Garzik wrote:

> With CONFIG_LBD, 32-bit machines can already support large block
> devices.
> 
> If you feel that hardcoding u64 as sector numbers will mean ext4 suddenly
> fails on 32-bit, you misunderstand the situation completely.

With CONFIG_LBD disabled you still had the truncation/complexity issues 
somewhere else, so you gain nothing, but waste memory in ext4.

bye, Roman
