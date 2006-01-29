Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWA2T5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWA2T5E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 14:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWA2T5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 14:57:04 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:58381 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751132AbWA2T5D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 14:57:03 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, thockin@hockin.org
Subject: Re: 2.6.15.1: persistent nasty hang in sync_page killing NFS
 (ne2k-pci / DP83815-related?), i686/PIII
References: <87fyn8artm.fsf@amaterasu.srvr.nix>
	<1138499957.8770.91.camel@lade.trondhjem.org>
	<87slr79knc.fsf@amaterasu.srvr.nix>
From: Nix <nix@esperi.org.uk>
X-Emacs: the Swiss Army of Editors.
Date: Sun, 29 Jan 2006 19:56:35 +0000
In-Reply-To: <87slr79knc.fsf@amaterasu.srvr.nix> (nix@esperi.org.uk's
 message of "Sun, 29 Jan 2006 14:24:55 +0000")
Message-ID: <8764o23j0s.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2006, nix@esperi.org.uk whispered secretively:
> On Sat, 28 Jan 2006, Trond Myklebust stipulated:
>> http://blogs.sun.com/roller/page/shepler?entry=port_623_or_the_mount
> 
> That's specific to one port. As the capture (from the server side this
> time) shows, the NFS client is using all sorts of ports on the client,
> and port 2049 on the server; acks are not required, this being UDP.
> 
> I'm going to rebuild with NFS-over-TCP support and see if that changes
> anything next. A bit pointless on a clean switched network, but it's
> hardly going to be noticeable...

Further info, possibly in support of your suggestion, possibly not: the
problem does *not* occur with NFS-over-TCP. So it's specific to UDP,
this hardware (perhaps motherboard or network card, see the .config
diff), *and* NFS. Other UDP stuff (e.g. DNS) gets through fine in both
directions; NFS works with TCP; and the whole lot worked before the
hardware was changed.

At this point though I'd say that it's really rather unlikely to be
purely hardware at fault.

> I'll get another network card on Monday and swap out the DP83815, and
> see if *that* changes anything.

No need now, I can make it appear and disappear on demand.

-- 
`I won't make a secret of the fact that your statement/question
 sent a wave of shock and horror through us.' --- David Anderson
