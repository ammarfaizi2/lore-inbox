Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbUCEKra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 05:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbUCEKra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 05:47:30 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:60048 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S262410AbUCEKr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 05:47:29 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Neil Brown <neilb@cse.unsw.edu.au>
Date: Fri, 5 Mar 2004 11:47:08 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [TRIVIAL][PATCH]:/proc/fs/nfsd/
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, okir@monad.swb.de,
       obelix123@toughguy.net
X-mailer: Pegasus Mail v3.50
Message-ID: <16B99F21693@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Mar 04 at 21:08, Neil Brown wrote:
> > The following patch fixes it.
> 
> Does it need fixing??
> 
> If you remove this, then people who compile a kernel without nfsd
> support, and then later decide to compile an nfsd module and load it,
> will not be able to mount the nfsd filesystem at the right place.

> I think it is a very small cost, and a measurable gain, to leave it
> there.

Maybe I'm stupid, but why cannot knfsd module create fs/nfsd
directory at module load? That way you can do insmod/modprobe followed 
by mount() to do that. And if you'll fiddle with do_mount a bit
(so that get_fs_type() is invoked before walking mount path)
you can do it even without modprobing knfsd in advance, by just
doing 'mount none /proc/fs/nfsd -t nfsd'.
                                                Petr Vandrovec

