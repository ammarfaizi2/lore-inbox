Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVGKF3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVGKF3L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 01:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVGKF1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 01:27:53 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:4952 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262247AbVGKF1t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 01:27:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uJ61AKSKTLe6xwopQp/qcbQGOgC1WbFtzlPASdvOSgaOdxXORVQxWiTCeVlrh1mXpGjvrXFSdt8pXNVXses6ldJ18Wa6VTp2Q8eulD7pKxONhgRSf+ykdkbfmv7ZIDCLFhqwX5nooiZkQskjLWQLWALg5TCQIhLipNZ7Qq8XxVA=
Message-ID: <29495f1d050710222746e892af@mail.gmail.com>
Date: Sun, 10 Jul 2005 22:27:46 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 0/82] changing CONFIG_LOCALVERSION rebuilds too much, for no good reason.
Cc: jgarzik@pobox.com, olh@suse.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050710.215847.41634202.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050710.144910.15269860.davem@davemloft.net>
	 <42D1A039.9090807@pobox.com>
	 <29495f1d050710211862c4e543@mail.gmail.com>
	 <20050710.215847.41634202.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/05, David S. Miller <davem@davemloft.net> wrote:
> From: Nish Aravamudan <nish.aravamudan@gmail.com>
> Date: Sun, 10 Jul 2005 21:18:15 -0700
> 
> > A quick question here regarding the possibility of one logical change
> > for all of drivers/. Does that hold true for *any* logical change?
> >
> > Intuitively, I would say no. My biggest concern with that is there are
> > many Maintainers listed for particular SCSI drivers, e.g., as well as
> > one for the SCSI subsystem. If those individual driver maintainers'
> > files are being modified, should they be CC'ed, or is the big patch
> > just sent to the SCSI maintainer (in this example)? I just want to
> > make sure the correct patch-chain is respected.
> 
> Please just use common sense.  It depends upon how intrusive the
> change is.  In most cases, the driver author's have to learn to
> "let go" and let these general cleanups happen.  The onus is on
> them to follow upstream when the submit new changes of their own.
> 
> Some examples:
> 
> 1) Deleting superfluous header file.
> 
>    Just do a clean sweep.
> 
> 2) Adding a new argument to an existing interface.
> 
>    Just do a clean sweep.
> 
> 3) Transitioning drivers over to a new exception handling mechanism.
> 
>    Probably want to do submit a patch for driver at a time.  You
>    should be doing more a few of these driver conversions at a time
>    anyways, so no risk of patch bombing.
> 
> 4) Straight forward transformations, for example hiding data
>    structure member access behind a function or macro.
> 
>    Just do a clean sweep in large chunks.
> 
> Again, use common sense.  If you're just crossing your "T"'s and
> dotting your "i"'s, don't spam everyone with a thousand patches
> for such a cleanup.

Great! Thanks for the quick feedback. I'll make sure this gets added
to the KJ FAQ (mayhap even verbatim :) )

Thanks,
Nish
