Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVGKEST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVGKEST (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 00:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVGKEST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 00:18:19 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:64324 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262227AbVGKESR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 00:18:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rPIn+QlgJQaFYW9YdfWBPN9h2cOjkKYiumQ5C5Q33WrosIjU3ngmnnY4BBNtme2CI6sYmaHuVRTgRcjoN9YltamlsCEWBGhgJyW4ksNGMHsmvWHGKAgU7iQSC6F+i2+98G6/AyxdDMUZulMp0H1j87rHzjCfycaAd/NhCV6Bcpo=
Message-ID: <29495f1d050710211862c4e543@mail.gmail.com>
Date: Sun, 10 Jul 2005 21:18:15 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/82] changing CONFIG_LOCALVERSION rebuilds too much, for no good reason.
Cc: "David S. Miller" <davem@davemloft.net>, olh@suse.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <42D1A039.9090807@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>
	 <20050710.144910.15269860.davem@davemloft.net>
	 <42D1A039.9090807@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> David S. Miller wrote:
> > Kernel janitor-like patches split up their work _FAR_ too much.  They
> > post one patch per driver, or even per-file, for something as simple
> > as removing the use of a redundant header file.  That's totally
> > rediculious, and bloats up the kernel changelog history for no good
> > reason.  Instead, you should just post one big patch for all of
> > drivers/, one for all of net/, something like that.
> 
> 
> Whoops, in an email just sent, I repeated what you said here, except
> that you said it better :)
> 
> 100% agreed...

A quick question here regarding the possibility of one logical change
for all of drivers/. Does that hold true for *any* logical change?

Intuitively, I would say no. My biggest concern with that is there are
many Maintainers listed for particular SCSI drivers, e.g., as well as
one for the SCSI subsystem. If those individual driver maintainers'
files are being modified, should they be CC'ed, or is the big patch
just sent to the SCSI maintainer (in this example)? I just want to
make sure the correct patch-chain is respected.

There is already a patch pending for the KJ FAQ from Domen Puncer
(http://lists.osdl.org/pipermail/kernel-janitors/2005-July/004438.html)
to note that the same logical change can be made for all of
drivers/net, e.g., in one patch, but it's still not quite clear how
the appropriate CCs should be respected. We should probably make that
as clear as possible now.

Thanks,
Nish
