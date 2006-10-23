Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbWJWTFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbWJWTFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWJWTFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:05:34 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:60069 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S965084AbWJWTFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:05:31 -0400
Date: Mon, 23 Oct 2006 15:05:00 -0400
From: David Hollis <dhollis@davehollis.com>
Subject: Re: 2.6.19-rc2-mm2: D-Link DUB-E100 Rev. B broken
In-reply-to: <200610232041.48998.bero@arklinux.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <1161630300.4824.7.camel@dhollis-lnx.sunera.com>
MIME-version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6)
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <200610232041.48998.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 20:41 +0200, Bernhard Rosenkraenzer wrote:
> Hi,
> D-Link DUB-E100 Rev. B USB Ethernet adapters have worked ok in some recent 
> kernels - in rc2-mm2, they're broken again; they're detected correctly and 
> the asix module is autoloaded, but after "ifconfig eth0 192.168.0.15 netmask 
> 255.255.255.0", the box becomes unresponsive and keeps repeating
> 
> eth0: Failed to enable software MII access
> eth0: Failed to enable hardware MII access
> eth0: Failed to enable software MII access
> eth0: Failed to enable hardware MII access
> eth0: Failed to enable software MII access
> eth0: Failed to enable hardware MII access
> eth0: Failed to enable software MII access
> eth0: Failed to enable hardware MII access
> eth0: Failed to enable software MII access
> eth0: Failed to enable hardware MII access
> eth0: Failed to write Medium Mode to 0x0334: ffffff92

Hmm, the only change that you may not have is to wrap the MII calls with
a Mutex, though that isn't likely the culprit here (even though the
message is talking about MII access).  Could you enable the DEBUG define
at the top of the driver and see what kind of output you get in dmesg?

-- 
David Hollis <dhollis@davehollis.com>

