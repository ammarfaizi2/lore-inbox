Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261820AbSI2WA3>; Sun, 29 Sep 2002 18:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261823AbSI2WA3>; Sun, 29 Sep 2002 18:00:29 -0400
Received: from pop.univ-lyon1.fr ([134.214.100.7]:14608 "HELO
	pop.univ-lyon1.fr") by vger.kernel.org with SMTP id <S261820AbSI2WA1>;
	Sun, 29 Sep 2002 18:00:27 -0400
Subject: Re: IDE Problems with 2.5.39
From: JF <mljf@altern.org>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D9775BF.3090504@walrond.org>
References: <3D9775BF.3090504@walrond.org>
Content-Type: text/plain
Organization: 
Message-Id: <1033337141.9053.6.camel@I401.resi.insa-lyon.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 30 Sep 2002 00:05:41 +0200
Content-Transfer-Encoding: 7bit
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-29 at 23:50, Andrew Walrond wrote:
> Hi,
> 
> I can't boot with 2.5.39 because the built-in  ide driver (ServerWorks 
> CSB5) can't see hda, and VFS says "Cannot open root device "hda3" or 
> 03:03" which results in a kernel panic
> 
> Works fine with 2.4.20-pre? with identical kernel setup and kernel 
> parameter root=/dev/hda3
> 
> Is this a known problem? Any way around it or patches?

I used to have this problem with 2.5 too
It went from the IDE controller chipset.

Are you sure that you have only 1 IDE controller chipset ?

I have both PIIX4 and HPT366. Root FS is on HPT366 controller. Enabling
only PIIX4 used to work with 2.4 but doesn't with 2.5 anymore (got
exactly your problem). I had to enable specific support for both.

I suppose your root FS is on a specific IDE controller for which the
support is not enabled (check the different type in the IDE/ATA kernel
config section)

Regards.

