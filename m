Return-Path: <linux-kernel-owner+w=401wt.eu-S1161042AbXALLLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbXALLLv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 06:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbXALLLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 06:11:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:8347 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161042AbXALLLu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 06:11:50 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ITkmQ7Cvvz8LlGJx/KjJjgmn0vwv52cpsO3c5mQYbE/09dZAo3qj+/ziLiRmUPByo70ZvkgcgbHPEnR9WYGHWtxQr2+0y6QMlHBzgPlmV52m3kbOW76HMzBPdeISSuDUy0/5h2Kq2P1O0B49g51ay4HExH6skLWnI7zkx+Dz+f0=
Message-ID: <414cba4e0701120311t39d90e10y472f251f8e357643@mail.gmail.com>
Date: Fri, 12 Jan 2007 12:11:49 +0100
From: emisca <emisca.ml@gmail.com>
To: "Stefan Seyfried" <seife@suse.de>
Subject: Re: [Suspend-devel] asus p5ld2 se, serial port gone after suspend and i8042 problems (solved, pnpacpi=off needed)
Cc: "Pavel Machek" <pavel@ucw.cz>, suspend2-users@lists.suspend2.net,
       suspend-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20070111195812.GF11903@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <414cba4e0701101409w4be38105vae7d185f4c2967bd@mail.gmail.com>
	 <20070111114202.GC5945@elf.ucw.cz>
	 <414cba4e0701110514t2fbd0659g905aa2fb06b9a261@mail.gmail.com>
	 <20070111195812.GF11903@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But using pnpacpi=no, I disable the acpi code.. the "normal" pnp code,
what does on suspend? Does it simply do nothing? In the dmesg I don't
see anything related to pnp device reinit.
I tried suspend to ram on this motherboard. A strange thing happens..
the system goes to suspend and then suddenly resumes. Why?
How I can check if it's enabled a wake up device? There are no related
settings on the bios, only wake on lan (disabled). I think I must
debug interrupts...

2007/1/11, Stefan Seyfried <seife@suse.de>:
> On Thu, Jan 11, 2007 at 02:14:42PM +0100, emisca wrote:
> > Yes, I have to look at pnpacpi code... but does the dsdt matters for this
> > problem?
> > Surely, it is a bios bug (as usually.....). I will look at pnpacpi code.
>
> Not necessarily. IIRC, somebody (Rusty?) said that serial consoles have had
> problems with suspend for a long time and just sometimes work "by accident".
> ISTR that they do not really save and restore the line settings etc.
>
> So it does not need to be the BIOS, it can also be a plain broken driver.
>
> --
> Stefan Seyfried
> QA / R&D Team Mobile Devices        |              "Any ideas, John?"
> SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out."
>
