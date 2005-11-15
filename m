Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbVKOJBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbVKOJBg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbVKOJBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:01:36 -0500
Received: from znsun1.ifh.de ([141.34.1.16]:28104 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S1751387AbVKOJBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:01:36 -0500
Date: Tue, 15 Nov 2005 10:00:50 +0100 (CET)
From: Patrick Boettcher <patrick.boettcher@desy.de>
X-X-Sender: pboettch@pub3.ifh.de
To: Chris Rankin <rankincj@yahoo.com>
Cc: David Brigada <brigad@rpi.edu>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb-maintainer] Re: [OOPS] Linux 2.6.14.2 and DVB USB
In-Reply-To: <20051114235102.64514.qmail@web52912.mail.yahoo.com>
Message-ID: <Pine.LNX.4.64.0511150939010.18517@pub3.ifh.de>
References: <20051114235102.64514.qmail@web52912.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: ALL_TRUSTED,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Nov 2005, Chris Rankin wrote:
> This sounds contrary to the entire concept of hotplugging to me. And I don't think that a typical
> desktop user would be happy to be told that s/he needs to become root and unload kernel modules
> before s/he can unplug a USB device.

Unfortunately the dvb-core is currently not able to handle hotplugging 
while a dvb application is accessing a dvb-dev-node. This applies 
for every dvb-device, not only for dvb-usb devices, but no one ever tried 
to unplug a DVB PCI card while using it, yet.

Before unplugging a device, you can check if the module is removable to 
make sure that really no application is currently using it. (You will get 
"module in use" then).

We already thought about that problem and we think that dvbdev.c is the 
correct place to start implementing that, but I don't have enough 
knowledge (and time) to do that now, sorry.

regards,
Patrick.
