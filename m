Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWEMAGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWEMAGF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 20:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWEMAGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 20:06:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:53929 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932221AbWEMAGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 20:06:00 -0400
X-Authenticated: #31060655
Message-ID: <44652292.6070401@gmx.net>
Date: Sat, 13 May 2006 02:04:34 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060316 SUSE/1.0-27 SeaMonkey/1.0
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, trenn@suse.de,
       thoenig@suse.de, stable@kernel.org
Subject: Re: [patch] smbus unhiding kills thermal management
References: <20060512095343.GA28375@elf.ucw.cz> <44645FC2.80500@gmx.net> <Pine.LNX.4.64.0605121547090.27910@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.64.0605121547090.27910@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Fri, 12 May 2006, Carl-Daniel Hailfinger wrote:
> 
>> Pavel Machek wrote:
>>> Do not enable the SMBus device on Asus boards if suspend
>>> is used. We do not reenable the device on resume, leading to all sorts
>>> of undesirable effects, the worst being a total fan failure after
>>> resume on Samsung P35 laptop.
>>>
>>> Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
>>> Signed-off-by: Pavel Machek <pavel@suse.cz>
>> This is probably also -stable material.
> 
> Isn't it inevitable that we're going to have to rerun quirks on resume on 
> some hardware?

Yes, but until we have a proper infrastructure for that, we have to
disable the smbus unhiding as a safe fix.

If you have the time to whip up a patch to add a sane quirks-on-resume
infrastructure, I'd be grateful. See the thread
"[RFC] [PATCH] Execute PCI quirks on resume from suspend-to-RAM" for
some ugly proof-of-concept.
My main motivation was to prevent bricking my laptop. Added functionality
is desirable, but secondary.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
