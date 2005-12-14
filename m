Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVLNQYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVLNQYi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVLNQYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:24:38 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:42638 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S964813AbVLNQYi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:24:38 -0500
Date: Wed, 14 Dec 2005 09:24:37 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-scsi@vger.kernel.org
Subject: Re: [patch 6/6] statistics infrastructure - exploitation: zfcp
Message-ID: <20051214162437.GW9286@parisc-linux.org>
References: <43A044E6.7060403@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A044E6.7060403@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 05:14:30PM +0100, Martin Peschke wrote:
>  	if (device_register(&unit->sysfs_device)) {
> +		zfcp_unit_statistic_unregister(unit);
>  		kfree(unit);
>  		return NULL;
>  	}
> 
>  	if (zfcp_sysfs_unit_create_files(&unit->sysfs_device)) {
> +		zfcp_unit_statistic_unregister(unit);
>  		device_unregister(&unit->sysfs_device);
>  		return NULL;
>  	}

Unrelated, but doesn't that error path forget to release unit?

