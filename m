Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277112AbRKAAxy>; Wed, 31 Oct 2001 19:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277135AbRKAAxf>; Wed, 31 Oct 2001 19:53:35 -0500
Received: from neptune-gw.phys.ufl.edu ([128.227.64.7]:33781 "HELO
	neptune.phys.ufl.edu") by vger.kernel.org with SMTP
	id <S277112AbRKAAxV>; Wed, 31 Oct 2001 19:53:21 -0500
Date: Wed, 31 Oct 2001 19:53:58 -0500 (EST)
From: John Stasko <stasko@phys.ufl.edu>
To: linux-kernel@vger.kernel.org
Cc: Alexander Madorsky <madorsky@phys.ufl.edu>
Subject: suspicious pci hang
Message-ID: <Pine.GSO.4.21.0110311930530.24268-100000@neptune.phys.ufl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kind Kernel Peoples:

Upon upgrading from the stock 2.2.14 kernel to the up2date RedHat 6.2 
2.2.19-6.2.7 kernel, the following line in my driver makes the system
fully hang:

	x = inl(reg->bmsr);

The board is in a pci space.  I suspect the board simultaneously
died some time around the upgrade or the perhaps the pci hardware
implementation is not quite stable, or, maybe something changed in the
kernel.

Yes, reg->bmsr contains a valid address (0x0000ec7c) and this value did
not get "stomped on" since the PCI block was requested.  Further, I know
this is the culprit by using {return -1;} before and after this line and
observing hang/nohang behaviour.

TIA and patiently waiting, 
     John Stasko, Department of Physics, University of Florida 
                  CMS project at CERN, Geneva 

