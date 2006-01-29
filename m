Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWA2UV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWA2UV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 15:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWA2UV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 15:21:28 -0500
Received: from pat.uio.no ([129.240.130.16]:54244 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751161AbWA2UV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 15:21:27 -0500
Subject: Re: 2.6.15.1: persistent nasty hang in sync_page killing NFS
	(ne2k-pci / DP83815-related?), i686/PIII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Nix <nix@esperi.org.uk>
Cc: linux-kernel@vger.kernel.org, thockin@hockin.org
In-Reply-To: <8764o23j0s.fsf@amaterasu.srvr.nix>
References: <87fyn8artm.fsf@amaterasu.srvr.nix>
	 <1138499957.8770.91.camel@lade.trondhjem.org>
	 <87slr79knc.fsf@amaterasu.srvr.nix>  <8764o23j0s.fsf@amaterasu.srvr.nix>
Content-Type: text/plain
Date: Sun, 29 Jan 2006 15:21:15 -0500
Message-Id: <1138566075.8711.39.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.059, required 12,
	autolearn=disabled, AWL 1.75, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-29 at 19:56 +0000, Nix wrote:
> Further info, possibly in support of your suggestion, possibly not: the
> problem does *not* occur with NFS-over-TCP. So it's specific to UDP,
> this hardware (perhaps motherboard or network card, see the .config
> diff), *and* NFS. Other UDP stuff (e.g. DNS) gets through fine in both
> directions; NFS works with TCP; and the whole lot worked before the
> hardware was changed.

If it works with TCP but not UDP, then the problem is usually either a
NIC driver issue, or a lossy network.
Comparing with DNS is not really useful, because NFS over UDP uses much
larger packet sizes (32k usually) which causes heavy use of
fragmentation.

Cheers,
 Trond

