Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVKNXln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVKNXln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVKNXln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:41:43 -0500
Received: from smtp1.server.rpi.edu ([128.113.2.1]:58087 "EHLO
	smtp1.server.rpi.edu") by vger.kernel.org with ESMTP
	id S932241AbVKNXlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:41:42 -0500
From: "David Brigada" <brigad@rpi.edu>
Date: Mon, 14 Nov 2005 18:39:24 -0500
To: Chris Rankin <rankincj@yahoo.com>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Linux 2.6.14.2 and DVB USB
Message-ID: <20051114233924.GA9772@localhost.localdomain>
References: <20051114210530.5657.qmail@web52901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114210530.5657.qmail@web52901.mail.yahoo.com>
User-Agent: Mutt/1.5.9i
X-CanItPRO-Stream: default
X-RPI-SA-Score: undef - spam-scanning disabled
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 09:05:29PM +0000, Chris Rankin wrote:
> Hi,
> 
> My Linux 2.6.14.2-SMP kernel has just exploded on me, after I detached
> my USB2 DVB USB adapter.  This is on a UP PIII 1GHz Coppermine
> machine. There was a storm of:
> 
> dvb-usb: bulk message failed: -19 (2/0)
> 
> messages between the disconnection and the eventual oops. Note also
> that the DVB device was attached to a USB2 hub.

Chris,

It seems as though there were messages that were still being sent to and
from your device when you disconnected it.  Try to make sure that you
quit all the software that was using the device, and if possible, remove
the kernel module that the device uses before removing the device.
You're right---it probably shouldn't cause an oops, but you should
probably make sure you aren't using it before unplugging it anyways.

-David Brigada
-- 
David Brigada | brigad@rpi.edu
