Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSLaNMi>; Tue, 31 Dec 2002 08:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSLaNMi>; Tue, 31 Dec 2002 08:12:38 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:27592 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261353AbSLaNMh>;
	Tue, 31 Dec 2002 08:12:37 -0500
Date: Tue, 31 Dec 2002 13:19:31 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Nathaniel Russell <reddog83@chartermi.net>, alan@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4-ac] VT8633 GART Support [RESEND] Corrected
Message-ID: <20021231131931.GC32207@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	Nathaniel Russell <reddog83@chartermi.net>, alan@redhat.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0212311106220.995-200000@reddog.example.net> <200212310523.43390.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212310523.43390.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2002 at 05:23:57AM +0100, Marc-Christian Petersen wrote:
 > > The first patch i sent to the list was wroung becaue i miss typed out the
 > > PCI_DEVICE... it was supposed to be PCI_DEVICE_ID_VIA_8633_0 pci id is
 > > 0x3091
 > > Well here is the complete fixed and correct version of my patch.
 > shouldn't this be exactly 8633_1 ? Assuming this is a AGP patch and: 
 > http://pciids.sourceforge.net/iii/?m=1&i=1106b091
 > tells the same, 8633_1 :)

No. We match on host bridge, as thats where the magick bits we
need to frob live. The bits in the AGP bridge are usually set up
by the BIOS. When we do need to poke them too, we go looking for
it in the initialisation routine.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
