Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311199AbSCPXQo>; Sat, 16 Mar 2002 18:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311203AbSCPXQY>; Sat, 16 Mar 2002 18:16:24 -0500
Received: from ns.suse.de ([213.95.15.193]:33298 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311199AbSCPXQV>;
	Sat, 16 Mar 2002 18:16:21 -0500
Date: Sun, 17 Mar 2002 00:15:33 +0100
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Anders Gustafsson <andersg@0x63.nu>, arjanv@redhat.com,
        linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] devexit fixes in i82092.c
Message-ID: <20020317001533.E15296@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Anders Gustafsson <andersg@0x63.nu>, arjanv@redhat.com,
	linux-kernel@vger.kernel.org, mochel@osdl.org
In-Reply-To: <E16mMer-0007Q4-00@the-village.bc.nu> <Pine.LNX.4.33.0203161421240.8278-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0203161421240.8278-100000@home.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 02:26:23PM -0800, Linus Torvalds wrote:

 > One question that hasn't come up: do we actually want to use the "remove"
 > function for this, or have a separate shutdown function? Are there reasons
 > to not use "remove" for shutdown?

 Something that came to mind on reading this thread that I want
 clarification on.. Take for example, the case of an IDE controller.
 If on shutdown we walk the driverfs tree shutting things down,
 it's going to power off its hard disks, then do whatever magic is
 needed to the ide host bridge.

 This makes sense for a shutdown, and suspend-to-disk, but not for
 a reboot imo (senseless spinning down/up of drives).
 So some means is probably going to be needed for drivers to
 distinguish between a reboot & shutdown/suspend.

 There may be other such devices too, but this was the more
 obvious one that came to mind. Or am I way off base here?
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
