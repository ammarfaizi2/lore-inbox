Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbUKVVlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbUKVVlA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbUKVVj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:39:58 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:6900 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261642AbUKVV3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:29:05 -0500
To: linux-kernel@vger.kernel.org
Cc: openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20041122713.SDrx8l5Z4XR5FsjB@topspin.com>
	<20041122713.g6bh6aqdXIN4RJYR@topspin.com>
	<20041122193350.GB8150@mars.ravnborg.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 22 Nov 2004 13:28:56 -0800
In-Reply-To: <20041122193350.GB8150@mars.ravnborg.org> (Sam Ravnborg's
 message of "Mon, 22 Nov 2004 20:33:50 +0100")
Message-ID: <521xeld147.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][RFC/v1][4/12] Add InfiniBand SA (Subnet Administration)
 query support
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Nov 2004 21:29:02.0226 (UTC) FILETIME=[492B9F20:01C4D0DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Sam> Nitpicking.

Great, thanks for the help :)  I'll fix these up before our next
version of the patches are posted.

    Sam> It's more readable to keep .o files on one line.

OK, I will reformat our Makefiles.  (I used the old style because it's
easier to add/remove source files, but I think you're right that it's
better to optimize for readability rather than the rare event of
adding/removing sources)

    Sam> For new stuff please use ib_core-y :=

OK, no problem (until a few days ago I didn't even know -y was
equivalent to -obj, let alone preferred).

    Sam> .h files for a subsystem like this ought to be placed in
    Sam> include/infiniband if they will be used by files in other
    Sam> directories than drivers/infiniband

Right now all the code is in drivers/infiniband.  However Christoph
suggested moving the .h files to include/infiniband as well.  I have
no problem moving the includes (and as you point out this eliminates
having to add a -I to our CFLAGS), but on the other hand do we want to
add a new toplevel include directory for what is still admittedly a
minor subsystem?

Thanks,
  Roland
