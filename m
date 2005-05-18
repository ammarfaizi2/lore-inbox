Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVERKN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVERKN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 06:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVERKN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 06:13:29 -0400
Received: from soundwarez.org ([217.160.171.123]:4580 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262152AbVERKNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 06:13:21 -0400
Subject: Re: [PATCH] Driver Core: remove driver model detach_state
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net
In-Reply-To: <11163679452255@kroah.com>
References: <11163679452255@kroah.com>
Content-Type: text/plain
Date: Wed, 18 May 2005 12:13:11 +0200
Message-Id: <1116411191.27701.4.camel@dhcp-188.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 15:12 -0700, Greg KH wrote:
> [PATCH] Driver Core: remove driver model detach_state
> 
> The driver model has a "detach_state" mechanism that:
> 
>  - Has never been used by any in-kernel drive;
>  - Is superfluous, since driver remove() methods can do the same thing;
>  - Became buggy when the suspend() parameter changed semantics and type;
>  - Could self-deadlock when called from certain suspend contexts;
>  - Is effectively wasted documentation, object code, and headspace.
> 
> This removes that "detach_state" mechanism; net code shrink, as well
> as a per-device saving in the driver model and sysfs.

Huh, we need to fix a lot of userspace programs now. libsysfs depends on
finding that file, udev waits for this to recognize sysfs population. I
will go fix this where I know this is used, but be prepared for stupid
failures... :)

Thanks,
Kay

