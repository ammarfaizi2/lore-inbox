Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTLCUvt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTLCUvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:51:49 -0500
Received: from scrye.com ([216.17.180.1]:63150 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S261193AbTLCUvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:51:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Wed, 3 Dec 2003 13:51:40 -0700
From: Kevin Fenzi <kevin@tummy.com>
To: Mark Haverkamp <markh@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux aacraid devel <linux-aacraid-devel@dell.com>
Subject: Re: aacraid and large memory problem (2.6.0-test11)
In-Reply-To: <1070396482.16903.11.camel@markh1.pdx.osdl.net>
References: <20031202193520.74481F7CC8@voldemort.scrye.com>
	<1070396482.16903.11.camel@markh1.pdx.osdl.net>
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Message-Id: <20031203205141.EB67EF7C86@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Mark" == Mark Haverkamp <markh@osdl.org> writes:

Mark> On Tue, 2003-12-02 at 11:35, Kevin Fenzi wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> 
>> Greetings,
>> 
>> Booting 2.6.0-test11 on a machine with 8GB memory and using the
>> aacraid driver results in a hang on boot. Passing mem=2048M causes
>> it to boot normally. 4GB also hangs. 2.6.0-test8 booted normally on
>> this same hardware.
>> 
>> 8GB memory, dual xeon 3.06mhz with hyperthreading, RedHat 9 on it
>> currently.
>> 
>> Happy to provide details on setup/software, etc.
>> 
>> Perhaps this patch in 2.6.0-test9 is the culprit?
>> http://www.linuxhq.com/kernel/v2.6/0-test9/drivers/scsi/aacraid/comminit.c

Mark> This patch is what made aacraid work with over 4 gig of memory
Mark> for me. I have an 8 proc system with 16gig of memory and without
Mark> this patch I get data corruption in high memory.

Mark> I don't boot on the aacraid though.

Is there any way you can try booting from it and see if it's a boot
issue for you as well?

I can try booting the one here from something else and see if it works
with that. 

kevin



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE/zkzd3imCezTjY0ERAtdRAJ9NIp56DWRFI6zxpbgyLtKQzkYcIACfYKil
Z6XcmnrXQ9Qsiy24d7ac044=
=a+PX
-----END PGP SIGNATURE-----
