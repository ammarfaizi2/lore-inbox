Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264012AbUEHSCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUEHSCg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 14:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbUEHSCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 14:02:35 -0400
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:33959 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S264012AbUEHSCe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 14:02:34 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] to fix i2o_proc kernel panic on access of /proc/i2o/iop0/lct
Date: Sat, 8 May 2004 17:39:43 +0200
User-Agent: KMail/1.6.2
Cc: Markus Lidel <Markus.Lidel@shadowconnect.com>
References: <409CC59B.3020500@shadowconnect.com>
In-Reply-To: <409CC59B.3020500@shadowconnect.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200405081739.50871.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Markus,

On Saturday 08 May 2004 13:33, Markus Lidel wrote:
> the patch fixes a bug in the i2o_proc.c module, where the kernel panics, 
> if you access /proc/i2o/iop0/lct and read more then 1024 bytes of it.
> 
> The problem was, that no paging was implemented by the function. This is 
> now solved.

What about solving this properly and using the seq_file API for this
problem class as anywhere else in the kernel?

Code will also get much more readable by this ;-)


Regards

Ingo Oeser


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAnP9FU56oYWuOrkARAgpwAKDHengtnPOk9c8mj7uD8mZkMx/LjACfWHts
utVH2yGfVRoJ7Sy8+bhJRBQ=
=E50x
-----END PGP SIGNATURE-----

