Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130386AbQLRF7p>; Mon, 18 Dec 2000 00:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130379AbQLRF7g>; Mon, 18 Dec 2000 00:59:36 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:65033 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129610AbQLRF73>; Mon, 18 Dec 2000 00:59:29 -0500
Date: Sun, 17 Dec 2000 23:28:46 -0600
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Monitoring filesystems / blockdevice for errors
Message-ID: <20001217232846.W3199@cadcamlab.org>
In-Reply-To: <20001217153453.O5323@marowsky-bree.de> <Pine.LNX.4.10.10012171314050.16143-100000@coffee.psychology.mcmaster.ca> <20001217194334.V5323@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001217194334.V5323@marowsky-bree.de>; from lmb@suse.de on Sun, Dec 17, 2000 at 07:43:35PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Mark Hahn]
> > reinventing /proc/kmsg and klogd would be tre gross.

[Lars Marowsky-Bree]
> Well, only one process can read kmsg and get notified about new
> messages at any time, so that makes the monitoring depend on
> klogd/syslogd working, which given a write error by syslog might not
> be the case...

So rewrite klogd to do something much simpler for serious errors (yes
they will be tagged as such) before trying to pass them on to syslogd.
Or does it already do this?  It's a userspace problem.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
