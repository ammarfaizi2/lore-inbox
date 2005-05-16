Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVEPRPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVEPRPP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 13:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVEPRPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:15:15 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:34105 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S261765AbVEPRPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:15:10 -0400
Message-ID: <4288D51D.8090401@pantasys.com>
Date: Mon, 16 May 2005 10:15:09 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Parpart <trapni@gentoo.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: I'm having 4GB RAM, but Linux sees just 3GB???
References: <200505161604.10881.trapni@gentoo.org>
In-Reply-To: <200505161604.10881.trapni@gentoo.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2005 17:13:54.0968 (UTC) FILETIME=[A39FA980:01C55A3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Parpart wrote:
> Has anyone a hint for my WHY this is happening and HOW I could get rid of it?

This is because there is a PCI memory hole of about 1GB of space on the 
x86_64 platform. Basically it overlays the address space of the RAM that 
you have.

You can try to enable memory hoisting (it may be called software memory 
hole in your bios). This will try to remap you RAM above the 4GB 
boundary so that the PCI space and your RAMs address space do not 
conflict. Unfortunately, this does not work particularly well...

peter
