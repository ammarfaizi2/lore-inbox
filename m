Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVBNKxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVBNKxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 05:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVBNKxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 05:53:13 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:36240 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261395AbVBNKxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 05:53:10 -0500
To: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
In-Reply-To: <20050210161809.GK3493@crusoe.alcove-fr>
References: <20050210161809.GK3493@crusoe.alcove-fr>
Date: Mon, 14 Feb 2005 10:53:10 +0000
Message-Id: <E1D0dqo-00041G-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop <stelian@popies.net> wrote:

> Privately I've had many positive feedbacks from users of this driver
> (and no negative feedback), including Linux distributions who wish
> to include it into their kernels. The reports are increasing in number,
> it would seem that newer Sony Vaios are more and more incompatible
> with sonypi and require sony_acpi to control the screen brightness.

The sonypi driver seems to be necessary to catch Vaio hotkey events,
including the sleep button. I've checked a couple of DSDTs, and it seems
that the more recent Vaios are lacking the SPIC entries but still don't
have the sleep button defined. Is there any chance of this driver being
able to catch hotkey events?

Related to that, I have a nastyish hack which lets the sonypi driver
generate ACPI events whenever a hotkey is pressed. Despite not strictly
being ACPI events, this makes it much easier to integrate sonypi stuff
with general ACPI support. I'll send it if you're interested.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
