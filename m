Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263863AbVBDSlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263863AbVBDSlD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 13:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbVBDSlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 13:41:02 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:50578 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265085AbVBDSfb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 13:35:31 -0500
Date: Fri, 4 Feb 2005 12:35:14 -0600
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, trini@kernel.crashing.org,
       paulus@samba.org, anton@samba.org, hpa@zytor.com
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
Message-ID: <20050204183514.GB17586@austin.ibm.com>
References: <20050204072254.GA17565@austin.ibm.com> <200502041336.59892.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502041336.59892.arnd@arndb.de>
User-Agent: Mutt/1.5.6+20040523i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 01:36:55PM +0100, Arnd Bergmann wrote:
> I have a somewhat similar patch that does the same to the
> systemcfg->platform checks. I'm not sure if we should use the same inline
> function for both checks, but I do think that they should be used in a
> similar way, e.g. CPU_HAS_FEATURE(x) and PLATFORM_HAS_FEATURE(x).

Yep. Firmware features are also on the list. I figured I'd do CPU features
first though since they are the ones that started bugging me.

> The same stuff is obviously possible for cur_cpu_spec->cpu_features as well.
> Do you think that it will help there?

Nice. It won't be quite as easy to do compile-time for cpu features.
pSeries will need all cpus enabled since we have them all on various
machines, etc. I guess Powermac/Maple could benefit from it. In the
end it depends on how hairy the implementation would get vs performance
improvement.


-Olof
