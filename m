Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWA2WCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWA2WCf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 17:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWA2WCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 17:02:34 -0500
Received: from pat.uio.no ([129.240.130.16]:3030 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751191AbWA2WCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 17:02:34 -0500
Subject: Re: 2.6.15.1: persistent nasty hang in sync_page killing NFS
	(ne2k-pci / DP83815-related?), i686/PIII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Nix <nix@esperi.org.uk>
Cc: linux-kernel@vger.kernel.org, thockin@hockin.org
In-Reply-To: <871wyq3dl3.fsf@amaterasu.srvr.nix>
References: <87fyn8artm.fsf@amaterasu.srvr.nix>
	 <1138499957.8770.91.camel@lade.trondhjem.org>
	 <87slr79knc.fsf@amaterasu.srvr.nix> <8764o23j0s.fsf@amaterasu.srvr.nix>
	 <1138566075.8711.39.camel@lade.trondhjem.org>
	 <871wyq3dl3.fsf@amaterasu.srvr.nix>
Content-Type: text/plain
Date: Sun, 29 Jan 2006 17:02:20 -0500
Message-Id: <1138572140.8711.82.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.324, required 12,
	autolearn=disabled, AWL 1.49, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-29 at 21:54 +0000, Nix wrote:
> (and surely if it was just packet loss, we wouldn't see *every* packet
> getting lost, for *hours*, as we saw here? I left five UDP NFS sessions
> frozen on Saturday night, and they were still frozen on Sunday morning,
> several NFS servers sending the same data to the failing client over and
> over every two seconds without fail, and the client seemingly
> disregarding all of it.)

As a general rule of thumb: if tcpdump/ethereal can see the reply on the
client, then the engine socket should see it too. If tcpdump is indeed
seeing those replies, you should check the RPC code by
setting /proc/sys/sunrpc/rpc_debug to 1.

If not, then perhaps you should try the debugging settings on your NIC
driver.

Cheers,
  Trond

