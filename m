Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbUAKXFh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 18:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266008AbUAKXFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 18:05:37 -0500
Received: from scrat.hensema.net ([62.212.82.150]:10926 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S266001AbUAKXFc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 18:05:32 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Re: LVM migration for 2.4->2.6, fallback path?
Date: Sun, 11 Jan 2004 23:05:24 +0000 (UTC)
Message-ID: <slrnc03llk.fvn.erik@dexter.hensema.net>
References: <20040111222223.GA9884@merlin.emma.line.org>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.3 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree (matthias.andree@gmx.de) wrote:
> Hi,
> 
> I understand that the following three combinations work (assuming
> 2.4.24/2.6.1):
> 
> Userspace           Kernelspace
> ------------------------------------------
> LVM1                2.4 LVM
> LVM2                2.4 + devmapper patch
> LVM2                2.6
> 
> But will LVM2 + 2.4 LVM work? LVM1 + 2.6 will not.

Just don't resize your volumes in 2.6, and you'll be fine.
Resizing causes 'vendor lock in' though ;-)

> I presume neither works, but if there is a way, I'd like to know to save
> myself some work.
> 
> Oh, and while I'm at it, what good is the "old ioctl" switch in kernel
> space? I am currently trying without and it works fine with a current
> LVM2 version (which is presumably how things are meant to be).

Just use the new ioctl, the old is just for compatibility with an
old lvm2 userspace. Clearly you don't have that.

-- 
Erik Hensema <erik@hensema.net>
