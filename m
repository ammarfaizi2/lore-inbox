Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266130AbRGGLvc>; Sat, 7 Jul 2001 07:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266131AbRGGLvV>; Sat, 7 Jul 2001 07:51:21 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:41927 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266130AbRGGLvN>;
	Sat, 7 Jul 2001 07:51:13 -0400
Message-ID: <3B46F7AF.5D677F1D@mandrakesoft.com>
Date: Sat, 07 Jul 2001 07:51:11 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        dhinds@zen.stanford.edu
Subject: Re: Memory region check in drivers/pcmcia/rsrc_mgr.c
In-Reply-To: <15174.62880.772230.734585@tango.paulus.ozlabs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> In drivers/pcmcia/rsrc_mgr.c, there is code that check whether a given
> range of PCI memory addresses are available for the pcmcia code to
> use.  This code uses a macro, check_mem_resource(), to check whether a
> particular region is available, defined like this:
> 
> #define check_mem_resource(b,n) check_resource(&iomem_resource, (b), (n))
[...]
> I think that
> we should be using check_mem_region instead,

AFAICS you are correct.

check_xxx is deprecated, though.  Is it possible to move a request_xxx
earlier in the logic?

check_xxx is inherently racy.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
