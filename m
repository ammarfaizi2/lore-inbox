Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVDDRLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVDDRLb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 13:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVDDRL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 13:11:29 -0400
Received: from smtpout17.mailhost.ntl.com ([212.250.162.17]:64692 "EHLO
	mta09-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S261296AbVDDRIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 13:08:54 -0400
Message-ID: <4251749B.5060603@gentoo.org>
Date: Mon, 04 Apr 2005 18:08:43 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050403)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Ford <david+challenge-response@blue-labs.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ALSA bugs with 2.6.12-rc1
References: <42515358.7020101@blue-labs.org>
In-Reply-To: <42515358.7020101@blue-labs.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> It seems that 2.6.12-rc1 introduced an ALSA bug generating an oops for a
> null pointer.
> 
> codec_semaphore: semaphore is not ready [0x1][0x300300]
> codec_read 0: semaphore is not ready for register 0x2c
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
> 
> This happens on multiple machines, 32b and 64bit.  I'll be happy to
> provide further information if needed.

This only happens when you mismatch your kernel and alsa-lib versions, e.g.
running alsa-lib-1.0.9-rc2 with alsa-1.0.8 in-kernel drivers, or possibly
vice-versa.

Daniel
