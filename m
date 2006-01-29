Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWA2OZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWA2OZU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 09:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWA2OZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 09:25:20 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:60943 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751005AbWA2OZU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 09:25:20 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, thockin@hockin.org
Subject: Re: 2.6.15.1: persistent nasty hang in sync_page killing NFS
 (ne2k-pci / DP83815-related?), i686/PIII
References: <87fyn8artm.fsf@amaterasu.srvr.nix>
	<1138499957.8770.91.camel@lade.trondhjem.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: if SIGINT doesn't work, try a tranquilizer.
Date: Sun, 29 Jan 2006 14:24:55 +0000
In-Reply-To: <1138499957.8770.91.camel@lade.trondhjem.org> (Trond
 Myklebust's message of "Sat, 28 Jan 2006 20:59:17 -0500")
Message-ID: <87slr79knc.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2006, Trond Myklebust stipulated:
> On Sat, 2006-01-28 at 22:52 +0000, Nix wrote:
> 
>> tcpdumps and the kernel's packet counters on both sides show NFS packets
>> flowing, and being retried, over and over again:
> 
> Are you using an Intel motherboard? If so, it could be the IPMI bug

The motherboard's an ASUS CUV4X, with VIA almost-everything. I think
this is the first mobo I've had in a decade that doesn't even have an
Intel PIIX bridge on it.

(One other machine in the house has VIA almost-everything as well, and
exhibits none of these problems.)

> http://blogs.sun.com/roller/page/shepler?entry=port_623_or_the_mount

That's specific to one port. As the capture (from the server side this
time) shows, the NFS client is using all sorts of ports on the client,
and port 2049 on the server; acks are not required, this being UDP.

I'm going to rebuild with NFS-over-TCP support and see if that changes
anything next. A bit pointless on a clean switched network, but it's
hardly going to be noticeable...

I'll get another network card on Monday and swap out the DP83815, and
see if *that* changes anything.

-- 
`I won't make a secret of the fact that your statement/question
 sent a wave of shock and horror through us.' --- David Anderson
