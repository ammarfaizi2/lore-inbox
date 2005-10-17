Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVJQBsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVJQBsr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 21:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVJQBsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 21:48:47 -0400
Received: from web50112.mail.yahoo.com ([206.190.39.149]:24427 "HELO
	web50112.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932120AbVJQBsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 21:48:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=r0MheqVSV+weMDmSfGi8f/wptFCI6riiah8V7tH4kE1sIilJuYWh+6L5LiDxfs2kYGqEOcWt/DQaDBtOn0v1OJuZ5BifYuo6yvy+jsxEfK2w01Ga6JOFsfQHEEa0qjGZHae5qiTF4hMzWwGZEqXl+RWL8Oh6SBhlYLGIaNJw69w=  ;
Message-ID: <20051017014845.16415.qmail@web50112.mail.yahoo.com>
Date: Sun, 16 Oct 2005 18:48:45 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: PATCH: EDAC, core EDAC support code
To: Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1129451124.2911.6.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Arjan van de Ven <arjan@infradead.org> wrote:

> > +
> > +static ctl_table mc_table[] = {
> > +	{-1, "panic_on_ue", &panic_on_ue,
> > +	 sizeof(int), 0644, NULL, proc_dointvec},
> > +	{-2, "log_ue", &log_ue,
> > +	 sizeof(int), 0644, NULL, proc_dointvec},
> > +	{-3, "log_ce", &log_ce,
> > +	 sizeof(int), 0644, NULL, proc_dointvec},
> > +	{-4, "poll_msec", &poll_msec,
> > +	 sizeof(int), 0644, NULL, proc_dointvec},
> > +	{-7, "panic_on_pci_parity",
> &panic_on_pci_parity,
> > +	 sizeof(int), 0644, NULL, proc_dointvec},
> > +	{-8, "check_pci_parity", &check_pci_parity,
> > +	 sizeof(int), 0644, NULL, proc_dointvec},
> > +#ifdef CONFIG_EDAC_DEBUG
> > +	{-9, "debug_level", &edac_debug_level,
> > +	 sizeof(int), 0644, NULL, proc_dointvec},
> > +#endif
> > +	{0}
> > +};
> 
> why aren't these module parameters? Nowadays you can
> have sysfs-runtime
> changable module parameters... sounds a lot nicer
> than adding a chunk of
> sysctl stuff
> 
> > +
> > +#ifdef CONFIG_PROC_FS
> > +static const char *mem_types[] = {
> > +	[MEM_EMPTY] = "Empty",
> > +	[MEM_RESERVED] = "Reserved",
> > +	[MEM_UNKNOWN] = "Unknown",
> > +	[MEM_FPM] = "FPM",
> > +	[MEM_EDO] = "EDO",
> > +	[MEM_BEDO] = "BEDO",
> > +	[MEM_SDR] = "Unbuffered-SDR",
> > +	[MEM_RDR] = "Registered-SDR",
> > +	[MEM_DDR] = "Unbuffered-DDR",
> > +	[MEM_RDDR] = "Registered-DDR",
> > +	[MEM_RMBS] = "RMBS"
> > +};
> 
> 
> why proc? Again this sounds like a platform sysfs
> thing...

The plan is to move from /proc to sysfs operations,
info and control. But the core works at this time and
patches will be forth coming once the baseline is in.
We want to make the currently work features "work".

doug "norsk" thompson



> 
> 
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

