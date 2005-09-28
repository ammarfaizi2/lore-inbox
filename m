Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVI1W1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVI1W1j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVI1W1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:27:39 -0400
Received: from web34110.mail.mud.yahoo.com ([66.163.178.108]:598 "HELO
	web34110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751127AbVI1W1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:27:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ezm5x712sVbqVzfcnygalPArn+3tgmLvBUWHBtTZxLx1oLE1PkMVAGfHvObx+ScTe5j4UAGZZYUUxUmjPK5lC40tOqPY/zQQ7AUv3HmMg4Bwl+LyeAUuoo6Mxq9IQAJZ9bOLWKZ4Jlh1VKUU3zHTiDDft6xgaMvTLq1eAXW5+q4=  ;
Message-ID: <20050928222738.95364.qmail@web34110.mail.mud.yahoo.com>
Date: Wed, 28 Sep 2005 15:27:38 -0700 (PDT)
From: Wilson Li <yongshenglee@yahoo.com>
Subject: Re: Slow loading big kernel module in 2.6 on PPC platform
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0509281548570.18498@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- "linux-os (Dick Johnson)" <linux-os@analogic.com> wrote:

> 
> On Wed, 28 Sep 2005, Wilson Li wrote:
> 
> > Hi,
> >
> > I am trying to port several third party kernel modules from
> kernel
> > 2.4 to 2.6 on a ppc (MPC824x) platform. For small size of
> modules, it
> > works perfectly in 2.6. But there's one huge kernel module which
> size
> > is about 2.7M bytes (size reported by lsmod after insmod), and it
> > takes about 90 seconds to load this module before init_module
> starts.
> > I did not notice there's such obvious delay in 2.4 kernel.
> >
> 
> I don't think it's a problem with the size. Here is the
> `lspci` output after I hacked a Rtc module to use 16 megabytes
> of data space. It took about 1/4 second to load (`time insmod
> Rtc.ko`).
> 
> Module                  Size  Used by
> Rtc                 16783748  0
> floppy                 58964  0
> loop                   18440  0
> parport_pc             28740  1
> lp                     14472  0
> parport                37320  2 parport_pc,lp
> 
> [SNIPPED...]
> 
> 
> > Initially I suspected there might be a problem of the insmod of
> > busybox I was using. I switched to module-init-tools-3.1 insmod.
> It
> > didn't help. I also tried other things like disabling
> CONFIG_KALLSYMS
> > and commenting out all the EXPORT_SYMBOLs in that module. Nothing
> > works so far. I've not been able to find any relevant thread
> about
> > slow loading of big kernel module on PPC platform.
> >
> 
> The PPC might be a bit slower, but not as slow as you are
> seeing. I suspect that you have something that is 'waiting'
> for initialization.

For debugging, my module init function will print a message first
when it gets called. After insmod the module, the console hangs about
90 seconds for loading then my init function gets called and message
prints. I even commented out all the initialization code, it still
does not help. Anything else I am missing?

Thanks,
Wilson Li


	
		
______________________________________________________ 
Yahoo! for Good 
Donate to the Hurricane Katrina relief effort. 
http://store.yahoo.com/redcross-donate3/ 

