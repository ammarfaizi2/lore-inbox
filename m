Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132226AbRDMWj3>; Fri, 13 Apr 2001 18:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132186AbRDMWjI>; Fri, 13 Apr 2001 18:39:08 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:33159 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S132147AbRDMWjF>; Fri, 13 Apr 2001 18:39:05 -0400
From: tom_gall@vnet.ibm.com
Message-ID: <3AD77FBF.874F8305@vnet.ibm.com>
Date: Fri, 13 Apr 2001 22:37:51 +0000
Reply-To: tom_gall@vnet.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: pmd_alloc, pte_alloc, Was Re: 2.4.3 and Alpha
In-Reply-To: <E14oBht-0003dd-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All, Alan,

  I realize I don't keep up with the linux kernel mailing list like i should but
the change to pmd_alloc and pte_alloc has me a little worried.

  I'm working on the ppc64 port (sources soon to be posted) and this change
affects one of the design attributes that we've had.

  Basically in the pmd, it would seem that the current design in 2.4.3 forces
you to have pointers in there. Currently in our source we're using offsets
instead of a 64 bit pointer... this of course saved us from having to alloc 2
contiguous pages in memory. 

  This isn't the end of the world, we can change over to using pointers but I
just wanted to confirm that that was the intent or maybe I'm missing something
and there is still a way out and still have our own arch dependant
implementations of pte_alloc and pmd_alloc.

  Regards,

  Tom

Alan Cox wrote:
> 
> > `pmd_alloc'
> > /usr/src/redhat/linux/include/linux/mm.h:412: previous declaration of
> > `pmd_alloc'
> > make: *** [init/main.o] Error 1
> >
> >
> > 2.4.1 compiled fine, and as far as I can see, some changes has been made
> > to mm.h since then. I think these changes was followed up by i386, ppc,
> > s390 and sparc64 kernels but not on others. Any plans on when this is
> > done ?
> 
> Its fixed in the -ac tree but I've yet to push that set of changes to Linus

-- 
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://oss.software.ibm.com/developerworks/opensource/linux
