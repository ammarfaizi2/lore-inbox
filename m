Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVLNRRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVLNRRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 12:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVLNRRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 12:17:25 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:52923 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750786AbVLNRRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 12:17:24 -0500
Date: Wed, 14 Dec 2005 18:17:14 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Andreas Herrmann <AHERRMAN@de.ibm.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, linux-scsi@vger.kernel.org
Subject: Re: [patch 6/6] statistics infrastructure - exploitation: zfcp
Message-ID: <20051214171714.GA11415@osiris.boeblingen.de.ibm.com>
References: <43A044E6.7060403@de.ibm.com> <20051214162437.GW9286@parisc-linux.org> <43A04E73.2020808@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A04E73.2020808@de.ibm.com>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>	if (device_register(&unit->sysfs_device)) {
> >>+		zfcp_unit_statistic_unregister(unit);
> >>		kfree(unit);
> >>		return NULL;
> >>	}
> >>	if (zfcp_sysfs_unit_create_files(&unit->sysfs_device)) {
> >>+		zfcp_unit_statistic_unregister(unit);
> >>		device_unregister(&unit->sysfs_device);
> >>		return NULL;
> >>	}
> >Unrelated, but doesn't that error path forget to release unit?
> 
> correct, I guess ... Andreas, could you fix this?

The release function frees the unit. Nothing to fix here.

Heiko
