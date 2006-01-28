Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWA1QEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWA1QEO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 11:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWA1QEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 11:04:13 -0500
Received: from adicia.telenet-ops.be ([195.130.132.56]:24219 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1751451AbWA1QEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 11:04:13 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org, kronos@kronoz.cjb.net
Subject: Re: Suspend to RAM: help with whitelist wanted
Date: Sat, 28 Jan 2006 17:04:18 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Matthew Garrett <mjg59@srcf.ucam.org>
References: <20060126213611.GA1668@elf.ucw.cz> <20060127232207.GB1617@elf.ucw.cz> <20060128155800.GA3064@dreamland.darkstar.lan>
In-Reply-To: <20060128155800.GA3064@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601281704.19050.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 January 2006 16:58, Luca wrote:
> - I must stop acpid before suspending otherwise it will get a "power
>   button pressed" event on resume and shutdown the machine; not related
>   to s2ram though.

You can fix that by e.g creating a file /tmp/acpi_sleep, and checking in the 
powerbutton routine if the file is present. Delete it if it is present, and 
just shutdown the machine if not. 

I have to do that too on my Acer TM803.

-- 
If this were Ada, I suppose we'd just constant fold 1/0 into

    die "Illegal division by zero"
		-- Larry Wall in <199711100226.SAA12549@wall.org>
