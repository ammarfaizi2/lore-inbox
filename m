Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751732AbWD1TWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbWD1TWr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 15:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWD1TWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 15:22:47 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:53705 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751432AbWD1TWq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 15:22:46 -0400
Date: Fri, 28 Apr 2006 14:22:43 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Ulrich Drepper <drepper@gmail.com>,
       Axelle Apvrille <axelle_apvrille@yahoo.fr>, Nix <nix@esperi.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       disec-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication of binaries
Message-ID: <20060428192243.GD31473@sergelap.austin.ibm.com>
References: <87slo2nn0b.fsf@hades.wkstn.nix> <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com> <a36005b50604280833k5a811384r5f3a6f92dd707256@mail.gmail.com> <20060428160914.GA31473@sergelap.austin.ibm.com> <20060428181612.GA19898@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060428181612.GA19898@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christoph Hellwig (hch@infradead.org):
> On Fri, Apr 28, 2006 at 11:09:14AM -0500, Serge E. Hallyn wrote:
> > BS - you can stack another LSM to prevent that.
> > 
> > Or, stack it with SELinux.  I've tested that combination before with no
> > problems.
> 
> The real question here is why use lsm at all?  lsm sounds like the wrong
> set of hooks for something like this.  If you look at the hooks they are
> clearly for access control handling, which this isn't at all.  I bet
> your code would be a lot simpler if you just hooked into the right places
> directly.  and made it controllable by selinux or $lsm.

The evm code (which should be released soon) introduces an integrity
subsystem, using TPM.  The crypto part of digsig could become another
user of that subsystem.

At that point like you say selinux could mark types which can cause
domain transitions as needing to be signed, and, if lsm's not dead,
other lsm's could use it other ways if they like.

thanks,
-serge
