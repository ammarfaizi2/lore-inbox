Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbVGMMdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbVGMMdY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 08:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbVGMMdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 08:33:24 -0400
Received: from mail.charite.de ([160.45.207.131]:53649 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S262812AbVGMMco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 08:32:44 -0400
Date: Wed, 13 Jul 2005 14:32:39 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Current kexec status?
Message-ID: <20050713123239.GT4561@charite.de>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20050713104848.GJ4561@charite.de> <20050713122257.GA29477@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050713122257.GA29477@in.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Vivek Goyal <vgoyal@in.ibm.com>:

> Can you give more details like
> - Which distro release you are running.

Debian unstable; since it has no kexec-tools, I built those from source.

> - Exactly what changes did you do to /etc/init.d/reboot and what steps
> did you follow to load the kernel (command line options).

/etc/init.d/reboot:
===================

echo -n "Rebooting... "
#reboot -d -f -i
/usr/local/sbin/kexec -f --exec --debug

Loading the Kernel in /etc/init.d/umountfs, before umount'ing /boot:
====================================================================

echo -n "Loading kernel for kexec()..."
/usr/local/sbin/kexec --load /vmlinuz
echo "done."

> - What do you see on screen? Did the new kernel start booting at all.

Nope, no booting. I get one line of output which I don't remember;
I'll have to retry.

> - Would be nice if I can get serial console output.

Sorry, no serial port here.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
