Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUGaUQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUGaUQF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 16:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUGaUQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 16:16:05 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:62386 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261610AbUGaUQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 16:16:02 -0400
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
From: Lee Revell <rlrevell@joe-job.com>
To: Ben Greear <greearb@candelatech.com>
Cc: Willy Tarreau <willy@w.ods.org>, Matti Aarnio <matti.aarnio@zmailer.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       alan@redhat.com, jgarzik@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <410BD525.3010102@candelatech.com>
References: <20040730121004.GA21305@alpha.home.local>
	 <E1BqkzY-0003mK-00@gondolin.me.apana.org.au>
	 <20040731083308.GA24496@alpha.home.local> <410B67B1.4080906@pobox.com>
	 <20040731101152.GG1545@alpha.home.local>
	 <20040731141222.GJ2429@mea-ext.zmailer.org>
	 <410BD0E3.2090302@candelatech.com>
	 <20040731170551.GA27559@alpha.home.local>
	 <410BD525.3010102@candelatech.com>
Content-Type: text/plain
Message-Id: <1091304989.1677.329.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 31 Jul 2004 16:16:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 13:21, Ben Greear wrote:
> Willy Tarreau wrote:
> > I've seen several drivers which silently add 4 bytes to the hardware
> > config when CONFIG_VLAN is set. I find it better than fooling the IP
> > stack into using 1504 bytes, which is a disaster on UDP !
> 
> It would be a disaster with any IP protocol, not just UDP.

UDP is prone to *much* weirded behavior than TCP in the face of things
like this.  I once had an NFS server and client using UDP.  A had its
block size set to 8K, B to 32K.  For some reason the mount succeeded
with these options, but when you copied a file from A to B (like, oh,
say, /etc/passwd), it "worked", but the file was truncated to 8K!  The
only indication that anything was wrong (other than hundreds of users
unable to log in) was a mild warning in the logs.

I am not sure what would have happened with a TCP mount, but not that!

Lee

