Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132690AbRDXCPU>; Mon, 23 Apr 2001 22:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132691AbRDXCPK>; Mon, 23 Apr 2001 22:15:10 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:3795 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S132690AbRDXCOx>;
	Mon, 23 Apr 2001 22:14:53 -0400
Message-ID: <3AE4E19D.41F117C1@mandrakesoft.com>
Date: Mon, 23 Apr 2001 22:14:53 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt_Domsch@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] adding PCI bus information to SCSI layer
In-Reply-To: <CDF99E351003D311A8B0009027457F140810E26A@ausxmrr501.us.dell.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt_Domsch@Dell.com wrote:
> 
> > PCI ids can be derived from bus/slot/function.
> 
> Even better.  I'll remove the extraneous fields then, and only return those.
> 
> typedef struct scsi_pci {
>         unsigned char   bus_number;
>         unsigned int    devfn;          /* encoded device & function index
> */
> } Scsi_Pci;

Why not pci_dev::slot_name?  Presumeably the only reason you need this
is to export it to userspace...  We already have the ASCII text there,
please consider using that :)

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
