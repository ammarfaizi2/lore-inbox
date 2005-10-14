Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVJNSWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVJNSWg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVJNSWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:22:36 -0400
Received: from pat.uio.no ([129.240.130.16]:46525 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750831AbVJNSWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:22:36 -0400
Subject: Re: NFS client problem with kernel 2.6 and SGI IRIX 6.5
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: ruediger@theo-phys.uni-essen.de
Cc: linux-kernel@vger.kernel.org, 325117@bugs.debian.org
In-Reply-To: <200510140905.LAA10947@next12.theo-phys.uni-essen.de>
References: <200510140905.LAA10947@next12.theo-phys.uni-essen.de>
Content-Type: text/plain
Date: Fri, 14 Oct 2005 14:22:22 -0400
Message-Id: <1129314142.8443.13.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.98, required 12,
	autolearn=disabled, AWL 1.02, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 14.10.2005 Klokka 11:05 (+0200) skreiv Ruediger Oberhage:
> Dear Trond Myklebust,
> 
> my name is Ruediger Oberhage, I'm (amongst other duties)
> administering computers for the Theoretical Physics in Essen of
> the university Duisburg-Essen, Germany, and I do have a (client)
> problem (severe to us) with the 2.6 kernel series and nfs, when
> served from an SGI IRIX 6.5 system (type: Origin 200).
> 
> Since I use the Debian GNU/Linux distribution, I contacted its kernel
> maintainer (Horms) first, and he pointed me to you (I'll add the
> problem report(s) below).
> 
> The problem was registered with the Debian Bug Tracking System as
> Bug#325117.
> 
> The summary is as follows: I do have problems with the 2.6 series
> kernel, which do not occur with a 2.4 series kernel (and an other-
> wise unchanged system). I discovered it with Mathematica version 5.0,
> but do think that other programs are also involved (e.g. OpenOffice
> 1.1.4, that doesn't find its default (or any other) printer any
> longer). The symptom is, that certain ressources are reported
> missing, that are definitively there and which lie somewhere
> within the application-tree, that tree lying within a hierarchie
> being nfs-auto-mounted from the SGI system to the (Intel architec-
> ture) Linux client. File contents (or whole files?) seems to get  
> 'lost' somehow.
> 
> It doesn't seem to be the MSBit Problem of the 32bit nfs cookies
> (alone) - the branch is exported with the IRIX '32bitclients'
> option, to avoid the 64bit cookies, that led to a similar problem
> with the printer in OpenOffice under the 2.4 series kernels, and
> vanished with the 32bit-option.  The reason for me to state this
> is, that when I applied a 32bit-'SGI-IRIX-induced'-patch for (early)
> 2.6 kernels (Debians 2.6.8) the problem didn't go away, and it also
> still occurs when using the 2.6.12-kernel, where some kernel-version
> ago (2.6.10 or 11?) that part of the cookie problem was solved via a  
> translation table (once and for all, I hope).
> 

Have you tried running "strace" on this find command in order to figure
out which syscall is returning EOVERFLOW? If it is getdents, please
could you confirm that the same error occurs in the same place on
2.6.12?

...Oh, and could I have a binary tcpdump of the traffic between the
client and server when this happens. Please use something like

tcpdump -w /tmp/dump.out -s 9000 host <servername> and port 2049

Cheers,
  Trond

