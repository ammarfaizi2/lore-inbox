Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTLCV55 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTLCV55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:57:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:62387 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262030AbTLCV5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:57:45 -0500
Subject: Re: aacraid and large memory problem (2.6.0-test11)
From: Mark Haverkamp <markh@osdl.org>
To: Kevin Fenzi <kevin@tummy.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux aacraid devel <linux-aacraid-devel@dell.com>
In-Reply-To: <20031203205141.EB67EF7C86@voldemort.scrye.com>
References: <20031202193520.74481F7CC8@voldemort.scrye.com>
	 <1070396482.16903.11.camel@markh1.pdx.osdl.net>
	 <20031203205141.EB67EF7C86@voldemort.scrye.com>
Content-Type: text/plain
Message-Id: <1070488662.21904.6.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Dec 2003 13:57:42 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-03 at 12:51, Kevin Fenzi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> >>>>> "Mark" == Mark Haverkamp <markh@osdl.org> writes:
> 
> Mark> On Tue, 2003-12-02 at 11:35, Kevin Fenzi wrote:
> >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >> 
> >> 
> >> Greetings,
> >> 
> >> Booting 2.6.0-test11 on a machine with 8GB memory and using the
> >> aacraid driver results in a hang on boot. Passing mem=2048M causes
> >> it to boot normally. 4GB also hangs. 2.6.0-test8 booted normally on
> >> this same hardware.
> >> 
> >> 8GB memory, dual xeon 3.06mhz with hyperthreading, RedHat 9 on it
> >> currently.
> >> 
> >> Happy to provide details on setup/software, etc.
> >> 
> >> Perhaps this patch in 2.6.0-test9 is the culprit?
> >> http://www.linuxhq.com/kernel/v2.6/0-test9/drivers/scsi/aacraid/comminit.c
> 
> Mark> This patch is what made aacraid work with over 4 gig of memory
> Mark> for me. I have an 8 proc system with 16gig of memory and without
> Mark> this patch I get data corruption in high memory.
> 
> Mark> I don't boot on the aacraid though.
> 
> Is there any way you can try booting from it and see if it's a boot
> issue for you as well?

I set up my machine to boot on the aacraid disk and it booted OK for
me.  Maybe its a problem with a particular model?

lspci on mine says:

02:04.0 RAID bus controller: Digital Equipment Corporation DECchip 21554 (rev 01)
        Subsystem: Adaptec Adaptec 5400S


> 
> I can try booting the one here from something else and see if it works
> with that. 
> 
> kevin
> 

-- 
Mark Haverkamp <markh@osdl.org>

