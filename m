Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVIBRod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVIBRod (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 13:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVIBRod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 13:44:33 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:61577 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750750AbVIBRoc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 13:44:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ohixbWbGaJguCMkGB10HctEez+p8BGC5KyHQDR36DZyC4cYo8Prsl+pFMo95JhH6FAae60MC91dRlrG3seSnD7INo8+EtNp2nj+SnFW61NgN/ng9RCj/U6vV5k+AFFOUNIdJBT/aO2Lf3xWzWRnMp5Gl+RWzZDZJh+4H17h8oJk=
Message-ID: <62b0912f05090210441d3fa248@mail.gmail.com>
Date: Fri, 2 Sep 2005 19:44:31 +0200
From: Molle Bestefich <molle.bestefich@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE HPA
Cc: ataraid-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1125680712.30867.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
	 <1125419927.8276.32.camel@localhost.localdomain>
	 <87941b4c050830095111bf484e@mail.gmail.com>
	 <62b0912f0509020027212e6c42@mail.gmail.com>
	 <1125666332.30867.10.camel@localhost.localdomain>
	 <62b0912f05090206331d04afd3@mail.gmail.com>
	 <E1EBCdS-00064p-00@chiark.greenend.org.uk>
	 <62b0912f05090209242ad72321@mail.gmail.com>
	 <1125680712.30867.20.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Molle Bestefich wrote:
> > Not if, as proposed, there was a kernel switch to enable including the
> > HPA in the disc area.
> 
> And users magically knew about it - thats why it has to default the
> other way.

Ok, so just to reiterate..

The current default is causing grief because dmraid doesn't work, grub
doesn't work and other userspace apps probably breaks too.  Users have
to google and post to mailing lists just to get things to work (... if
they could, which would require eg. a kernel option, but anyway).

The other way round, users would have to google to find the kernel
option that claims the HPA area (if they felt the need to overwrite
the BIOS's backup area), but those that felt the need would then be
rewarded with eg. 10 GB extra disk space.  And if they didn't feel
like it, their userspace apps would still work just fine.

>From my POV it's hard to see why the current default is sensible.

(We'll probably just have to agree on disagreeing, unless you can enlighten me.)

Related matters:
If you decide to include the HPA in one of your filesystems, is there
not a big risk that the BIOS will overwrite something there?
