Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130770AbQJLPZY>; Thu, 12 Oct 2000 11:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S130701AbQJLPZO>; Thu, 12 Oct 2000 11:25:14 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:59657 "EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id <S130699AbQJLPYy>; Thu, 12 Oct 2000 11:24:54 -0400
Message-ID: <39E5D4A2.E26836A9@mandrakesoft.com>
Date: Thu, 12 Oct 2000 11:11:30 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Francois romieu <romieu@ensta.fr>
CC: linux-kernel@vger.kernel.org, aprasad@in.ibm.com
Subject: Re: ioremap of pci base addresses
References: <CA256976.001F00B2.00@d73mta05.au.ibm.com> <20001012105200.A28642@nic.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois romieu wrote:
>         token = (unsigned long)ioremap(pci_resource_start(pdev, 0),
>                                           pci_resource_len(pdev, 0));

Looks great except for one small point -- we have been going through
drivers cleaning up where they start casting like this.  You should this
token as a void*, and code which uses the value should adjust
accordingly...

	Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
