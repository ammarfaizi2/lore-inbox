Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWA1QjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWA1QjF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 11:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWA1QjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 11:39:05 -0500
Received: from pat.uio.no ([129.240.130.16]:9977 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751469AbWA1QjE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 11:39:04 -0500
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths
	library
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David =?ISO-8859-1?Q?H=E4rdeman?= <david@2gen.com>
Cc: Adrian Bunk <bunk@stusta.de>, Christoph Hellwig <hch@infradead.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060128104611.GA4348@hardeman.nu>
References: <20060127092817.GB24362@infradead.org> <1138312694656@2gen.com>
	 <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com>
	 <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de>
	 <20060128104611.GA4348@hardeman.nu>
Content-Type: text/plain; charset=utf-8
Date: Sat, 28 Jan 2006 11:37:51 -0500
Message-Id: <1138466271.8770.77.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.701, required 12,
	autolearn=disabled, AWL 1.11, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-28 at 11:46 +0100, David Härdeman wrote:

> Not necessarily, if you have your ssh-keys in ssh-agent, a compromise of 
> your account (forgot to lock the screen while going to the bathroom? 
> did the OOM-condition occur which killed the program which locks the
> screen? remote compromise of the system? local compromise?) means that a large 
> array of attacks are possible against the daemon.
> 
> In addition, as stated before, the "backup" account, or whatever user the 
> daemon which wants to sign stuff with your key is running as, might be 
> compromised.
> 
> Currently, if you want to give the daemon access to the keys via 
> ssh-agent (or something similar), you have to change the permissions on 
> the ssh-agent socket to be much less restricted (especially since it's 
> unlikely that you have permission to change the uid or gid of the socket 
> to that of the daemon). Alternatively you can provide the backup daemon 
> with the key directly (via fs, or loaded somehow at startup...etc), but 
> then a compromise of the daemon means that the attacker has the private 
> key.
> 
> Finally, the in-kernel system also provides a mechanism for the daemon 
> to request the key when it is needed should it realize that the proper 
> key is missing/has changed/whatever.

Then fix ssh, not the kernel. As I said before, this is a problem that
has been solved entirely in userspace by means of proxy certificates:
they allow the user to issue time-limited certificates that are signed
by the original certificate (hence can be authenticated as such), and
that authorise a service to do a specific thing.

Cheers,
  Trond

