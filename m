Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269320AbUI3P7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269320AbUI3P7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 11:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269316AbUI3P5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 11:57:14 -0400
Received: from scrye.com ([216.17.180.1]:3464 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S269311AbUI3P4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 11:56:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Sep 2004 09:56:41 -0600
From: Kevin Fenzi <kevin-linux-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
X-Draft-From: ("scrye.linux.kernel" 72141)
References: <415C2633.3050802@0Bits.COM>
Message-Id: <20040930155644.BFF1CD6F5D@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Mitch" == Mitch  <Mitch@0Bits.COM> writes:

Mitch> Hi, Anyone noticed that pmdisk software suspend stopped working
Mitch> in -rc3 ?  In -rc2 it worked just fine. My script was

Mitch>   chvt 1 echo -n shutdown >/sys/power/disk echo -n disk
Mitch> >/sys/power/state chvt 7

Mitch> In -rc3 it appears to write pages out to disk, but never shuts
Mitch> down the machine. Is there something else i need to do or am
Mitch> missing ?

What do you get from:

cat /sys/power/disk
?

If it says "platform" you might try: 

echo "shutdown" > /sys/power/disk

I wonder how many of Pavel's speed improvment patches went in with the
pmdisk/swsusp merge in rc3? I guess I can try it and see. :) 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBXCy83imCezTjY0ERAoZDAJ0fDwzvvl6+5o48qGmBVN2OIgXbfwCeOU2n
/AUAFfEXKKV/uW6tWTLdmd0=
=u85n
-----END PGP SIGNATURE-----
