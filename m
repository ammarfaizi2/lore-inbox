Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269105AbUIRC3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269105AbUIRC3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 22:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbUIRC3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 22:29:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25259 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269105AbUIRC3A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 22:29:00 -0400
Date: Fri, 17 Sep 2004 22:04:59 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: achim.leubner@intel.com
Cc: linux-kernel@vger.kernel.org, achim@vortex.de
Subject: Re: memory allocation error messages in system log
Message-ID: <20040918010459.GA5660@logos.cnet>
References: <NEBBILBHKLDLOMLDGKGNEEKDCIAA.Ingo.Freund@e-dict.net> <20040916211408.GE12022@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916211408.GE12022@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Achim,

This is not the first person I see complaining about 
exact same bug (memory allocation failure while reading
/proc/scsi/gdt/xxx

Do you have a card around so we can test?

Thanks

On Thu, Sep 16, 2004 at 06:14:08PM -0300, Marcelo Tosatti wrote:
> On Thu, Sep 16, 2004 at 02:48:40PM +0200, Ingo Freund wrote:
> > Hello,
> > 
> > I hope you guys can help, I cannot use any kernel 2.4 >23 without
> > the here described problem.
> > 
> > [1.] One line summary of the problem:
> > strange error messages concerning memory allocation
> > 
> > searching teh web for solutions to my problem I have already found
> > a thread in a mailing list but no solution was mentioned, also the
> > guys who talked about the error didn't answer to my direct mail.
> > 
> > [2.] Full description of the problem/report:
> > The machine is a database server without any other service except sshd
> > running. I do some tests on the ICP-Vortex GDT controller every 2 minutes.
> > by using
> > # cat /proc/scsi/gdt/2
> > but the output of cat stops without beeing completed.
> > 
> > This is what I see in the syslog file every time when I use the cat
> > command (the messages beginn after 3 days uptime):
> > --> /var/log/messages
> > kernel: __alloc_pages: 0-order allocation failed (gfp=0x21/0)
> 
> Ingo,
> 
> I've seen another report like this one - I'm convinced there
> is something odd with the gdth proc handling code.
> 
> Can you "echo 1 > /proc/sys/vm/vm_gfp_debug" and 
> rerun the "cat /proc/scsi/gdt/2" please?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
