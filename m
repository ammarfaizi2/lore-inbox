Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbULFLCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbULFLCU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 06:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbULFLB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 06:01:58 -0500
Received: from mail.suse.de ([195.135.220.2]:28861 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261492AbULFLBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 06:01:53 -0500
Message-ID: <41B42E21.9090003@suse.de>
Date: Mon, 06 Dec 2004 11:02:09 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041104)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org
Subject: Re: [PATCH/RFC] Add support to resume swsusp from initrd
References: <1102279686.9384.22.camel@tyrosine> <20041205211230.GC1012@elf.ucw.cz>
In-Reply-To: <20041205211230.GC1012@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>>echo -n "set 03:02" >/sys/power/resume
> 
> I'd prefer not to have this one. Is it actually usefull? Then resume
> could be triggered by echo -n "03:02" > /sys/power/resume...

This could be made into a useful interface:

echo "set 03:02" > /sys/power/resume
sets the resume device _and_ verifies its signature etc, the basic
sanity check done before resume. If this fails, we can go into some
interactive setup etc.
OTOH, the "resume 03:02" could also just fail if the image is invalid...

       Stefan

