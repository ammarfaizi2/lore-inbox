Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129067AbRBHQle>; Thu, 8 Feb 2001 11:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbRBHQlY>; Thu, 8 Feb 2001 11:41:24 -0500
Received: from cmr2.ash.ops.us.uu.net ([198.5.241.40]:31637 "EHLO
	cmr2.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S129067AbRBHQlJ>; Thu, 8 Feb 2001 11:41:09 -0500
Message-ID: <3A82CBCE.6926AFAF@uu.net>
Date: Thu, 08 Feb 2001 11:39:42 -0500
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: vandrove@vc.cvut.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x, drm, g400 and pci_set_master
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure about the mga source, but you can enable busmaster manually
as root.  See the dri-devel list for more.  I can't remember the exact
message off hand.  THere was also some discussion of this last week I
think.

Alex


----------------------------

Hi, 
  friend of mine bought g400 on my recommendation, and unfortunately, 
mga drm driver did not worked for me. I tracked it down to missing 
pci_enable_device and pci_set_master in mga* driver. But even after 
looking more than hour into that code I have no idea where I should 
place this call, as it looks like that mga driver is completely 
shielded from seeing pcidev structure :-( 
  Does anybody know where I should place pci_enable_device and 
pci_set_master into mga code? I worked around pci_enable_device by 
using matroxfb, but pci_set_master is not invoked by matroxfb, and 
adding this call into matroxfb just to get mga drm driver to work does 
not look correctly to me - although it is what I had done just now. 
                                    Thanks, 
                                            Petr Vandrovec 
                                            vandrove@vc.cvut.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
