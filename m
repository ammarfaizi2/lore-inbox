Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWDXUpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWDXUpf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWDXUpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:45:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39316 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751263AbWDXUpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:45:34 -0400
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for
	run-timeauthentication of binaries
From: Arjan van de Ven <arjan@infradead.org>
To: Nix <nix@esperi.org.uk>
Cc: "Makan Pourzandi (QB/EMC)" <makan.pourzandi@ericsson.com>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Serue Hallyen <serue@us.ibm.com>,
       Axelle Apvrille <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       disec-devel@lists.sourceforge.net
In-Reply-To: <87hd4ipvdk.fsf@hades.wkstn.nix>
References: <6D19CA8D71C89C43A057926FE0D4ADAA29D361@ecamlmw720.eamcs.ericsson.se>
	 <1145897277.3116.44.camel@laptopd505.fenrus.org>
	 <87hd4ipvdk.fsf@hades.wkstn.nix>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 22:45:26 +0200
Message-Id: <1145911526.3116.71.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 21:32 +0100, Nix wrote:
> On 24 Apr 2006, Arjan van de Ven announced authoritatively:
> > On Mon, 2006-04-24 at 12:27 -0400, Makan Pourzandi (QB/EMC) wrote:
> >> Hi Arjan, 
> >> 
> >> I hope I correctly understood your question, DigSig uses LSM hooks to
> >> check the digital signature before loading it, then as long as your elf
> >> loader uses kernel system calls, it's covered by DigSig. 
> > 
> > ok I have to admit that this answer worries me.
> > 
> > how can it be covered? How do you distinguish an elf loader application
> > (which just uses open + mmap after all) with... say a grep-calling perl
> > script?
> 
> It checks mmap and mprotect with PROT_EXEC, and execve().

so no jvm's or flash plugins.

and the stack can be executable if the app wants it to be as well...
so it's not all that easy as you make it sound

> will sign every ELF shared object and executable on the system.

but it won't sign the not-really-elf-but-virus-anyway files. 

