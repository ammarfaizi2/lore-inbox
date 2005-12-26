Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbVLZEEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbVLZEEh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 23:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbVLZEEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 23:04:37 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:43122 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750986AbVLZEEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 23:04:37 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Date: Sun, 25 Dec 2005 23:04:30 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
References: <20051225212041.GA6094@hansmi.ch>
In-Reply-To: <20051225212041.GA6094@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512252304.32830.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 December 2005 16:20, Michael Hanselmann wrote:
> This patch adds a basic input hook support to usbhid because the quirks
> method is outrunning the available bits. A hook for the Fn and Numlock
> keys on Apple PowerBooks is included.

Well, we have used 11 out of 32 available bits so there still some
reserves. My concern is that your implementation allows only one
hook to be installed while with quirks you can have several of them
active per device.

As far as the hook itself - i have that feeling that it should not be
done in kernel but via a keymap.
 
-- 
Dmitry
