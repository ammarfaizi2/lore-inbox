Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933542AbWKQM3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933542AbWKQM3s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 07:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933553AbWKQM3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 07:29:48 -0500
Received: from gundega.hpl.hp.com ([192.6.19.190]:35520 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S933542AbWKQM3r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 07:29:47 -0500
Date: Fri, 17 Nov 2006 04:29:22 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] i386 add Intel PEBS and BTS cpufeature bits and detection
Message-ID: <20061117122922.GE19907@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061115213241.GC17238@frankl.hpl.hp.com> <200611170529.02460.ak@suse.de> <20061117075750.GA19907@frankl.hpl.hp.com> <200611171022.20708.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611171022.20708.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 10:22:20AM +0100, Andi Kleen wrote:
> > The former
> > stores from/to information into MSRs and is very small (4 branches). 
> 
> P4 since Prescott has 16
> 
Yes. I was talking about Core 2 

> > On recent processors LBR and BTS can be constrained by priv level.
> 
> Doesn't help for kernel debugging.
> 
Well, if you set if for kernel level only, you do not capture user level
branches. This may happen if you crash soon after you've entered the kernel
and you have a small buffer.

-- 
-Stephane
