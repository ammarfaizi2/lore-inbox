Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265563AbRGCHFo>; Tue, 3 Jul 2001 03:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265565AbRGCHFe>; Tue, 3 Jul 2001 03:05:34 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:45478 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265563AbRGCHFY>;
	Tue, 3 Jul 2001 03:05:24 -0400
Message-ID: <3B416EAE.B02C7751@mandrakesoft.com>
Date: Tue, 03 Jul 2001 03:05:18 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sean Hunter <sean@dev.sportingbet.com>
Cc: kaos@ocs.com.au, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: modules and 2.5
In-Reply-To: <3B415489.77425364@mandrakesoft.com> <20010703075050.B15457@dev.sportingbet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Hunter wrote:
> 
> Does this defeat my favourite module-related gothcha, that the machine panics
> if I have (say) a scsi driver builtin to the kernel and the same driver tries
> to load itself as a module?

Other, existing mechanisms should prevent conflicts here.  If a builtin
SCSI driver loads successfully, then its calls to request_region,
request_mem_region, or pci_request_regions should have succeeded.

If so, any attempt to grab those I/O regions by another driver,
including another instance of the same driver, should fail.

-- 
Jeff Garzik      | "I respect faith, but doubt is
Building 1024    |  what gives you an education."
MandrakeSoft     |           -- Wilson Mizner
