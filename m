Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291620AbSBHPwN>; Fri, 8 Feb 2002 10:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291621AbSBHPwD>; Fri, 8 Feb 2002 10:52:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:34949 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291620AbSBHPvs>;
	Fri, 8 Feb 2002 10:51:48 -0500
Date: Fri, 08 Feb 2002 07:48:57 -0800 (PST)
Message-Id: <20020208.074857.88474129.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: davej@suse.de, eike@bilbo.math.uni-mannheim.de,
        linux-kernel@vger.kernel.org
Subject: Re: [2.5.4-pre3] link error in drivers/video/video.o
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16ZDNA-00045D-00@the-village.bc.nu>
In-Reply-To: <20020208155733.F32413@suse.de>
	<E16ZDNA-00045D-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Fri, 8 Feb 2002 15:55:35 +0000 (GMT)
   
   That is incorrect. The warning occurs because someone made bogus changes to
   the vesa driver without understanding what was going on. The vesa frame
   buffer returned by the BIOS is a physical cpu address not a bus address
   and nothing to do with magic PCI mappings.

There were no changes made, in fact the VESA driver by your own
definition was buggy before my changes went in. :-) It was using
bus_to_virt and virt_to_bus all along Alan.
