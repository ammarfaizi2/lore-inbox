Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWEHPmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWEHPmU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 11:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWEHPmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 11:42:20 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:45673 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932377AbWEHPmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 11:42:20 -0400
Date: Mon, 8 May 2006 17:42:18 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
Message-ID: <20060508154217.GH1875@harddisk-recovery.com>
References: <200605051010.19725.jasons@pioneer-pra.com> <20060507095039.089ad37c.akpm@osdl.org> <445F548A.703@mbligh.org> <1147100149.2888.37.camel@laptopd505.fenrus.org> <20060508152255.GF1875@harddisk-recovery.com> <1147102290.2888.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147102290.2888.41.camel@laptopd505.fenrus.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 05:31:29PM +0200, Arjan van de Ven wrote:
> On Mon, 2006-05-08 at 17:22 +0200, Erik Mouw wrote:
> > ... except that any kernel < 2.6 didn't account tasks waiting for disk
> > IO.
> 
> they did. It was "D" state, which counted into load average.

They did not or at least to a much lesser extent. That's the reason why
ZenIV.linux.org.uk had a mail DoS during the last FC release and why we
see load average questions on lkml.

I've seen it on our servers as well: when using 2.4 and doing 50 MB/s
to disk (through NFS), the load just was slightly above 0. When we
switched the servers to 2.6 it went to ~16 for the same disk usage.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
