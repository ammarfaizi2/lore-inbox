Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVCCHIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVCCHIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 02:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVCCGwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 01:52:33 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:16658 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261549AbVCCGbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 01:31:44 -0500
Date: Thu, 3 Mar 2005 07:30:01 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Amol <amol@teneoris.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initrd and Initramfs
Message-ID: <20050303063001.GF30106@alpha.home.local>
References: <1109830227.4063.60.camel@amol.teneoris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109830227.4063.60.camel@amol.teneoris.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 11:40:27AM +0530, Amol wrote:
> Hi,
>  For an embedded developers perspective, Is there any other advantage of
> using initramfs over initrd apart from RAMFS benefits over RAMDISK ?

The fact that both are cumulable is very handy. Basically, you put all
the common tools and filesystem bits in the initramfs, and only add modules
or add-ons in each initrd depending on your target system. Even if you work
on embedded system, as soon as there are chances that you have to deal with
several hardware models, you may be interested in supporting them with just
a small initrd difference.

Regards,
Willy

