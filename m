Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265741AbRGGCac>; Fri, 6 Jul 2001 22:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265801AbRGGCaX>; Fri, 6 Jul 2001 22:30:23 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:2315 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S265741AbRGGCaO>;
	Fri, 6 Jul 2001 22:30:14 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15174.29463.304974.820632@tango.paulus.ozlabs.org>
Date: Sat, 7 Jul 2001 12:25:27 +1000 (EST)
To: linux-kernel@vger.kernel.org
Subject: drivers/ide/sl82c105.c
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am wondering who maintains drivers/ide/sl82c105.c, and who sent in
the recent changes to it.  We now have, at around line 278, this code:

unsigned int pci_init_sl82c105(struct pci_dev *dev, const char *msg)
{
        return ide_special_settings(dev, msg);
}

The call to ide_special_settings gives a link error because
ide_special_settings is not exported from drivers/ide/ide-pci.c.
I can't see what the point of calling it is anyway, even if it were
exported, since ide_special_settings consists of a switch statement on
the device ID and none of the cases will match.

Paul (who uses sl82c105.c on his longtrail PPC CHRP box).
