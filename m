Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270585AbUJTU7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270585AbUJTU7e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269066AbUJTU66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:58:58 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:29403 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269992AbUJTU44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:56:56 -0400
Subject: Re: forcing PS/2 USB emulation off
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Alexandre Oliva <aoliva@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <20041017225733.GA25435@kroah.com>
References: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <20041017225733.GA25435@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098302041.12412.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 20 Oct 2004 20:54:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-10-17 at 23:57, Greg KH wrote:
> It's already in the -mm kernels, and will be sent to Linus after 2.6.9
> is out.  If you could test that kernel and verify that it works for this
> situation, I would appreciate it.

It would be ok if someone bothered to copy the USB core code (or better
yet call into it) but the patch in the -mm tree doesn't know about the
zillion OHCI controller bugs, and doesn't know about the suprise
interrupt on switch from BIOS->host you sometimes see.

The real fix is to link the USB code early enough to run before the PC
keyboard code. I've had this confirmed by BIOS folks as well.

But *please* if you are going to copy USB mode switching code copy
working code including all the nasty gungy details!

