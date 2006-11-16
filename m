Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031191AbWKPQs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031191AbWKPQs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 11:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031192AbWKPQs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 11:48:27 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:27891 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1031191AbWKPQs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 11:48:26 -0500
Subject: Re: [Patch -mm 2/2] driver core: Introduce device_move(): move a
	device to a new parent.
From: Kay Sievers <kay.sievers@vrfy.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Greg K-H <greg@kroah.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
In-Reply-To: <20061116154210.217f2e04@gondolin.boeblingen.de.ibm.com>
References: <20061116154210.217f2e04@gondolin.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 17:47:37 +0100
Message-Id: <1163695657.7900.9.camel@min.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4ddcc9dd12ba6cf3155e4d81b383efda
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-16 at 15:42 +0100, Cornelia Huck wrote:
> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Provide a function device_move() to move a device to a new parent device. Add
> auxilliary functions kobject_move() and sysfs_move_dir().
> kobject_move() generates a new uevent of type KOBJ_MOVE, containing the
> previous path (OLD_DEVPATH) in addition to the usual values.

> +	sprintf(devpath_string, "OLD_DEVPATH=%s", devpath);

I think it's easier to understand, if the variable starts with the same
string as original name. I prefer DEVPATH_OLD.

> +void kobject_uevent_extended(struct kobject *kobj, enum kobject_action action,
> +			     const char *string)

I think we should pass an array of env vars here instead of a single
string - you never know ... :) The function could probably be named
kobject_uevent_env() then.

Thanks,
Kay

