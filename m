Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTLWPXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 10:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTLWPXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 10:23:12 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:59297 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S261464AbTLWPW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 10:22:57 -0500
Message-ID: <3FE85533.E026DE86@sgi.com>
Date: Tue, 23 Dec 2003 08:46:11 -0600
From: Colin Ngam <cngam@sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.79C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
References: <20031220122749.A5223@infradead.org> <Pine.SGI.3.96.1031222204757.20064A-100000@fsgi900.americas.sgi.com> <20031223090227.A5027@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> On Mon, Dec 22, 2003 at 08:55:10PM -0600, Pat Gefre wrote:
> > + Well, the pci-reorg patch is just wrong with tht remaining stuff
> > + and breaks the portable I/O code for IP27 and SN2 I'm working on.
> >
> > I have not heard any compelling reasons for keeping non-ia64, non-Altix
> > code in the ia64, Altix code base. The code re-org is aimed towards a
> > new ASIC we are working on - we feel it is needed.
>
> Again, you can reorganize code as much as you want.  Just don't change
> macro names randomly.  And the reason is once again that there will be
> a code drop supporting SN2 and IP27 in the same codebase soon, going
> the usual linux way of architecture-independant drivers for common hardware.

Hi Christoph,

You are ofcourse talking about linux/drivers/.. right?

IP27 is not a supported architecture under linux/arch/ia64/sn/io/..
The IP27 MIPS processor/io hardware(bridge/Xbridge)/BIOS for IP27 are very much
different than our SN2 product, supported within the linux/arch/ia64 tree -
ia64 processors, IO Chipsets(PIC, TIO(CP,CA)), and System BIOS.

Is that not supported under the linux/arch/mips tree?

Happy Holidays all.

colin

>
>
> > + issues before merging, it's not that much anyway..
> >
> > I think I did. I sent another email with the changes I made for the
> > issues you raised - and updated the patches. If I missed any, please
> > let me know.
>
> Ok, I haven't looked at that yet.
>
> > David or Andrew can you take these patches ?
>
> Please backpourt the renaming first.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

