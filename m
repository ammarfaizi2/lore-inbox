Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbUD1XMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUD1XMW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 19:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUD1XMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 19:12:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56787 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261779AbUD1XMP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 19:12:15 -0400
Date: Wed, 28 Apr 2004 20:13:20 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Juergen Stohr <juergen.stohr@lpr.e-technik.tu-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG]linux-2.4.26 Quad-Opteron: panic when init scsi
Message-ID: <20040428231320.GA16387@logos.cnet>
References: <20040427101720.GA27663@rcs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427101720.GA27663@rcs.ei.tum.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 12:17:20PM +0200, Juergen Stohr wrote:
> Hi,
> 
> I have got a problem similar to the one discussed in the thread
> "[BUG]linux-2.4.24 with k8 numa support panic when init scsi": When 
> booting the 2.4.26 on a quad Opteron box, in most of the cases the 
> kernel crashes when initializing SCSI.
> It seems to me that this bug is caused by a race, as in a few
> cases the machine is able to boot.
> 
> The machine always boots if I set maxcpus=1.
> 
> If I append numa=off to the command line the kernel crashes with a
> "Machine Check Exception" (but is able to initialize SCSI; perhaps
> this is another bug?)
> 
> Does anybody know how to solve this problem or is anybody working on it?
> Can someone give me a hint where to start when debugging this race?
> 
> I will attach the config of my kernel, the syslogs and the output of
> ksymoops.

Andi,

Have you seen Juergen's ksymoops trace? 

It seems some BUG() (maybe BAD_RANGE()) is triggering at startup in 
__alloc_pages().

