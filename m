Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264032AbUECVap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264032AbUECVap (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbUECVaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:30:30 -0400
Received: from hermes.dur.ac.uk ([129.234.4.9]:23778 "EHLO hermes.dur.ac.uk")
	by vger.kernel.org with ESMTP id S264040AbUECV2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:28:43 -0400
Subject: Re: arch/ia64/ia32/binfmt_elf32.c: elf32_map() broken ia64 build
	_and_ boot
From: Mike Hearn <mh@codeweavers.com>
To: Paul Jackson <pj@sgi.com>
Cc: John Reiser <jreiser@BitWagon.com>, akpm@osdl.org, pageexec@freemail.hu,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       ashok.raj@intel.com
In-Reply-To: <20040503140459.10b9d3eb.pj@sgi.com>
References: <20040426185633.7969ca0d.pj@sgi.com>
	 <20040501013304.32a750d3.pj@sgi.com> <4096526C.4060503@BitWagon.com>
	 <20040503140459.10b9d3eb.pj@sgi.com>
Content-Type: text/plain
Organization: Codeweavers, Inc
Message-Id: <1083619742.24587.3.camel@linux.littlegreen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Mon, 03 May 2004 22:29:03 +0100
Content-Transfer-Encoding: 7bit
X-DurhamAcUk-MailScanner: Found to be clean, Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 14:04 -0700, Paul Jackson wrote:
> Since I see Andrew dropped the patch for the moment, I'm thinking that
> the ball is back in you guys court.  

We've been able to develop a (complex) workaround for the VM layout
problems in userspace by inserting a shim between the dynamic linker and
the kernel. It sets up the address space correctly before the linker
runs so, for now, Wine will be alright without the patch - assuming we
can get the shim merged with Wine CVS of course :)

It would be nice to get the bssprot patch in though, if only because a
GNU linker script would be about 100x smaller and less scary than the
shim code.

thanks -mike

-- 
Mike Hearn <mh@codeweavers.com>
Codeweavers, Inc

