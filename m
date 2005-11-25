Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161105AbVKYPco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161105AbVKYPco (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbVKYPco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:32:44 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:44818 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1161105AbVKYPcn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:32:43 -0500
To: Rob Landley <rob@landley.net>
Cc: Neil Brown <neilb@suse.de>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: pivot_root broken in 2.6.15-rc1-mm2
References: <17283.52960.913712.454816@cse.unsw.edu.au>
	<200511230602.53960.rob@landley.net>
	<87psopkkqm.fsf@amaterasu.srvr.nix>
	<200511250716.29127.rob@landley.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: resistance is futile; you will be assimilated and byte-compiled.
Date: Fri, 25 Nov 2005 15:32:25 +0000
In-Reply-To: <200511250716.29127.rob@landley.net> (Rob Landley's message of
 "Fri, 25 Nov 2005 07:16:28 -0600")
Message-ID: <87oe48kak6.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2005, Rob Landley prattled cheerily:
> (Another is that calling chroot and such after deleting their binaries out of 
> initramfs but before the paths are adjusted so that the ones in the new root 
> can find their shared libraries is a bit of a headache.  It's a lot easier to 
> just have it all in one binary that's already loaded everything it needs and 
> frees its memory on exec.)

Oh yes, agreed 100%: this is one of those rare places where doing shell-like
stuff in a tiny dedicated binary really does make sense.

-- 
`Y'know, London's nice at this time of year. If you like your cities
 freezing cold and full of surly gits.' --- David Damerell

