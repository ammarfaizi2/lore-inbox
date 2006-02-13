Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWBMX1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWBMX1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWBMX1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:27:43 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:23577 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030278AbWBMX1m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:27:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ecEuhQF026Pv1Y3eWRRgKoZGCxIcgPmhaXs4guZrAnaNNpc+N5pqXmWiQB2WughzL/XPrvMFi+Y5Eez22XrzJxxlD8+cgcerrxEOyiD98mV1zkOdCOu9PAZfHoeP5OYiNsIqHg4FPDz0oj1YvzWhkrRwkAuyONrJxlodA8xjvNI=
Message-ID: <530468570602131527nbd17ddn262b92304adf4f86@mail.gmail.com>
Date: Mon, 13 Feb 2006 16:27:40 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.16-rc3: more regressions
Cc: Adrian Bunk <bunk@stusta.de>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie,
       dri-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0602131115010.3691@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	 <20060213170945.GB6137@stusta.de>
	 <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org>
	 <20060213174658.GC23048@redhat.com>
	 <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org>
	 <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org>
	 <20060213183445.GA3588@stusta.de>
	 <Pine.LNX.4.64.0602131043250.3691@g5.osdl.org>
	 <20060213190907.GD3588@stusta.de>
	 <Pine.LNX.4.64.0602131115010.3691@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Mon, 13 Feb 2006, Adrian Bunk wrote:
> >
> > The one thing I have not yet been proven wrong for is that this PCI id
> > is the only one we have in this driver for an RV370.
>
> It definitely is an RV370, you're right in that. I'm too lazy to actually
> see if the other entries that claim to be RV350's really are RV350's.
>

Well a while back, I hacked in the pci id for my Xpress 200M (5955),
which is basically an RV370 with no dedicated vram.  I did the same
thing and claimed an RV350, which is the closest model.  This allowed
the radeon module to load.  When I startx'ed and DRI was allowed to
load on it, it locked up.  So I never sent in the patch.  I believe
the person who sent this one in originally seemed to indicate that it
worked, and I believed it if he had an X300 and my problem was having
the IGP version.  But now having this reported, I'm pretty sure it is
the same problem.  RV370 doesn't seem to work as an RV350.

Jesse
