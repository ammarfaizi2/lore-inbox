Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130607AbRADIsu>; Thu, 4 Jan 2001 03:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131689AbRADIsl>; Thu, 4 Jan 2001 03:48:41 -0500
Received: from smtp4.ihug.co.nz ([203.109.252.5]:4102 "EHLO smtp4.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S130607AbRADIsY>;
	Thu, 4 Jan 2001 03:48:24 -0500
Message-ID: <3A543837.DFF61275@ihug.co.nz>
Date: Thu, 04 Jan 2001 21:45:43 +1300
From: david <sector2@ihug.co.nz>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: big memory maping problim
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi
i have kernel 2.2.18

i need a dma buffer (dose not have to be linear)

so i used vmalloc to get the space then i need to make it
non_cache so i found cr3 the got the page entry and got the phys page
address
also setting bit 4 of the page entry to disable caching and then
reloading cr3
when i had done all the pages to reset the tlb's this worked fine but
now i need to shear the mem with a user program so in  my driver mmap
function

i got vm->start and current ->tss->cr3
this give me to page entree witch i then set to the phys addr of the
above pages
this seam's to work fine

is their any thing else i need to do ?

remap_pages_range did not work on this mem but dose work on other
address spaces ?

Thank You

David Rundle <sector2@ihug.co.nz>



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
