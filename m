Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132046AbRDGW33>; Sat, 7 Apr 2001 18:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132049AbRDGW3T>; Sat, 7 Apr 2001 18:29:19 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:25783 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132046AbRDGW3O>;
	Sat, 7 Apr 2001 18:29:14 -0400
Message-ID: <3ACF94B9.F576D7EC@mandrakesoft.com>
Date: Sat, 07 Apr 2001 18:29:13 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gunther Mayer <Gunther.Mayer@t-online.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH for Broken PCI Multi-IO in 2.4.3 (serial+parport)
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <20010407111419.B530@redhat.com> <3ACF5F9B.AA42F1BD@t-online.de> <20010407200340.C3280@redhat.com> <3ACF6920.465635A1@mandrakesoft.com> <3ACF76B7.44F6279@t-online.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gunther Mayer wrote:
> More module interdependencies == More complicated == More clueless users

With module autoloading, they don't have to care about module
interdependencies.  The primary thing people care about is what string
is passed to modprobe.  When that changes, things break.  As long as
that doesn't change, you are ok.  Who cares if two or five or ten helper
modules are automatically pulled in, and who cares if that list of
helper modules changes...  Functionally speaking, the user is completely
unaware of the change.


> Many users will be surprised if they must load another module (e.g."pci_multiio")
> to get their parallel and serial ports working.
> 
> Thus _must not_ happen in the stable release.

Agreed.

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
