Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbUKSIIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbUKSIIQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 03:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbUKSIIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 03:08:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30679 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261302AbUKSIIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 03:08:14 -0500
Date: Fri, 19 Nov 2004 03:08:11 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: tridge@samba.org
cc: linux-kernel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <16797.41728.984065.479474@samba.org>
Message-ID: <Xine.LNX.4.44.0411190302300.8456-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2004 tridge@samba.org wrote:

> The tmpfs+xattr failure above is because tmpfs didn't seem to allow
> user xattrs, despite having CONFIG_TMPFS_XATTR=y.

tmpfs does not have a 'user' xattr handler.  xattr support was added to 
tmpfs only to provide a 'security' xattr handler which calls out to LSM 
modules such as SELinux.


- James
-- 
James Morris
<jmorris@redhat.com>


