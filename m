Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWDZDlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWDZDlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 23:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbWDZDli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 23:41:38 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:9695 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751640AbWDZDlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 23:41:32 -0400
Date: Tue, 25 Apr 2006 15:30:02 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Nix <nix@esperi.org.uk>
Cc: Ulrich Drepper <drepper@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       Makan Pourzandi <Makan.Pourzandi@ericsson.com>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Serue Hallyen <serue@us.ibm.com>,
       Axelle Apvrille <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       "disec-devel@lists.sourceforge.net" 
	<disec-devel@lists.sourceforge.net>
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-time authentication of binaries
Message-ID: <20060425203002.GB7228@sergelap.austin.ibm.com>
References: <4448AC62.6090303@ericsson.com> <1145794712.3131.10.camel@laptopd505.fenrus.org> <a36005b50604230938k2f52186ek477850b3e3a7192@mail.gmail.com> <87psj6pvqo.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87psj6pvqo.fsf@hades.wkstn.nix>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nix (nix@esperi.org.uk):
> On 23 Apr 2006, Ulrich Drepper prattled cheerily:
> > On 4/23/06, Arjan van de Ven <arjan@infradead.org> wrote:
> >> does this also prevent people writing their own elf loader in a bit of
> >> perl and just mmap the code ?
> > 
> > You will never get 100% protection from a mechanism like signed
> > binaries.  What you can get in collaboration with other protections
> > like SELinux is another layer of security.  That's good IMO.  Not
> > being able to slide in modified and substituted binaries which then
> > would be marked to get certain privileges is a plus.
> 
> Of course in order to use it in conjunction with SELinux right now you
> need LSM stacking, which is a nest of dragons in itself (if not used
> very carefully stacking can weaken security rather than strengthening
> it...)

Perhaps.  On the other hand, combining selinux with digsig you get:

	1. selinux integrity controls on crucial digsig files, which
	digsig does not (and should not) protect itself
	2. digsig controls over selinux entry types.  So now you can
	protect domain transitions with small, verifiable entry points
	which are then signed to boot.

> `Stripped-down firewalls' on its own is a big niche.

Every home should have one.

> Combine it with SELinux, exec-shield, FORTIFY_SOURCE, -fstack-protector
> and, say, a COWed filesystem read off a CD and reset with every boot,
> and you start to get a bit less insecure than you would otherwise be.

Sounds like a good basis for a new tiny distro.

-serge
