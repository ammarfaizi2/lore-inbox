Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313759AbSDZJk2>; Fri, 26 Apr 2002 05:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313762AbSDZJk1>; Fri, 26 Apr 2002 05:40:27 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:14599 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313759AbSDZJk1>; Fri, 26 Apr 2002 05:40:27 -0400
Date: Fri, 26 Apr 2002 10:40:17 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jurriaan on Alpha <thunder7@xs4all.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: compiling cmipci in 2.5.10 on Alpha doesn't work
Message-ID: <20020426104017.B16265@flint.arm.linux.org.uk>
In-Reply-To: <20020426130514.A20345@jurassic.park.msu.ru> <Pine.LNX.4.33.0204261113230.487-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 11:17:23AM +0200, Jaroslav Kysela wrote:
> The real fix is to add '#include <linux/pci.h>' line to all necessary 
> source files (sound/pci/cmipci.c in this example). Not all source files 
> need pci.h for compilation.

You'd also need to forward-declare struct pci_dev in sound/driver.h to
stop the compiler complaining about 'struct pci_dev' in function
prototypes.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

