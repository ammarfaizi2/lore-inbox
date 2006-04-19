Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWDSJIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWDSJIo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 05:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWDSJIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 05:08:44 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:54497 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750805AbWDSJIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 05:08:44 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Jon Masters <jonathan@jonmasters.org>
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Date: Wed, 19 Apr 2006 11:07:10 +0200
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20060418234156.GA28346@apogee.jonmasters.org>
In-Reply-To: <20060418234156.GA28346@apogee.jonmasters.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604191107.10562.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

> However, there is right now little mechanism in place to automatically
> determine which binary firmware blobs must be included with a kernel in
> order to satisfy the prerequisites of these drivers. This affects
> vendors, but also regular users to a certain extent too.
> 
> The attached patch introduces MODULE_FIRMWARE as a mechanism for
> advertising that a particular firmware file is to be loaded - it will
> then show up via modinfo and could be used e.g. when packaging a kernel.

I haven't really understood what problem this solves.  Is this just a
standardised form of documentation, or are you imagining that an automatic
tool will use this to auto include a minimal set of firmware files in an
initrd?  I'm thinking of something like this: (1) redhat (or whoever) ships
firmware files for every driver under the sun in /lib/firmware; (2) redhat
wants to allow users to have a customized initrd with only essential drivers;
(3) the tool goes through the list of essential drivers, looks up the firmware
string via MODULE_FIRMWARE, finds the file in /lib/firmware, and includes it
in the initrd.

All the best,

Duncan.
