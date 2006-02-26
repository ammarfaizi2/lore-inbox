Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWBZULI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWBZULI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 15:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWBZULI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 15:11:08 -0500
Received: from pproxy.gmail.com ([64.233.166.183]:8906 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750744AbWBZULG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 15:11:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QO2p+etrlgcx4Z9RTBQQwXNt/dIyyP7ltlR3qQMSWIDfhxEkf1NdamjPkxnuOtub0y4yTxAGvPPNKpEWC0fhoC0ihJTWTbjrtbV+xeNyWMRxZTvwwdIBcykQQwK1H23sSyIKoJlZDxrZAmKchF1YmjfPFPcPshkdVVaGQuT771U=
Message-ID: <9a8748490602261211q2ac857degc384fb9f72cc7b99@mail.gmail.com>
Date: Sun, 26 Feb 2006 21:11:06 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Dave Jones" <davej@redhat.com>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200602262043.22463.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602261721.17373.jesper.juhl@gmail.com>
	 <9a8748490602260835l2430e841p2bf02c1f99e55b91@mail.gmail.com>
	 <20060226193121.GG7851@redhat.com>
	 <200602262043.22463.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On Sunday 26 February 2006 20:31, Dave Jones wrote:
> > On Sun, Feb 26, 2006 at 05:35:49PM +0100, Jesper Juhl wrote:
> >
> >  > And for those who want to see a list of the unique errors, here they are :
> >  >
> >  > make: *** [.tmp_vmlinux1] Error 1
> >  > make: *** [arch/i386/kernel] Error 2
> >  > make: *** [drivers] Error 2
> >  > make: *** [sound] Error 2
> >  > make: *** [vmlinux] Error 1
> >  > make[1]: *** [arch/i386/kernel/irq.o] Error 1
> >  > make[1]: *** [drivers/acpi] Error 2
> >  > make[1]: *** [drivers/atm] Error 2
> >  > make[1]: *** [drivers/isdn] Error 2
> >  > make[1]: *** [drivers/media] Error 2
> >  > make[1]: *** [drivers/mtd] Error 2
> >  > make[1]: *** [drivers/scsi] Error 2
> >  > make[1]: *** [drivers/usb] Error 2
> >  > make[1]: *** [sound/isa] Error 2
> >  > make[1]: *** [sound/oss] Error 2
> >  > make[2]: *** [drivers/acpi/numa.o] Error 1
> >  > make[2]: *** [drivers/acpi/numa.o] Error 1  LD [M]  fs/ext3/ext3.o
> >  > make[2]: *** [drivers/acpi/osl.o] Error 1
> >  > make[2]: *** [drivers/atm/fore200e_pca_fw.c] Error 254
> >  > make[2]: *** [drivers/isdn/hysdn] Error 2
> >  > make[2]: *** [drivers/media/dvb] Error 2
> >  > make[2]: *** [drivers/mtd/maps] Error 2
> >  > make[2]: *** [drivers/scsi/aic7xxx] Error 2
> >  > make[2]: *** [drivers/usb/net] Error 2
> >  > make[2]: *** [sound/isa/opti9xx] Error 2
> >  > make[3]: *** [drivers/isdn/hysdn/hysdn_net.o] Error 1
> >  > make[3]: *** [drivers/media/dvb/ttpci] Error 2
> >  > make[3]: *** [drivers/mtd/maps/nettel.o] Error 1
> >  > make[3]: *** [drivers/scsi/aic7xxx/aicasm/aicasm] Error 2
> >  > make[3]: *** [drivers/usb/net/cdc_subset.o] Error 1
> >  > make[3]: *** [sound/isa/opti9xx/opti92x-ad1848.o] Error 1
> >  > make[3]: *** [sound/isa/opti9xx/opti93x.o] Error 1
> >  > make[4]: *** [aicasm] Error 1
> >  > make[4]: *** [drivers/media/dvb/ttpci/av7110_firm.h] Error 255
> >
> > You snipped out the interesting parts, which is 1-2 lines before this
> > (Grepping for Error: should do it)
> >
>
> $ grep -B 3 Error *.log
>
[snip grep output]

btw, if you want the complete logs and the configs that generated
them, then they are available in a tarball at
ftp://ftp.kernel.org/pub/linux/kernel/people/bunk/jesper/ and as
individual files in the logs/ subdir at the same location.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
