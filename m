Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161343AbWALWCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161343AbWALWCJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161342AbWALWCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:02:09 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:61756 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161345AbWALWCH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:02:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D1kEs7EfRtVUL4sl3/NfOcdxBitm4Kd5f05YRMmVizFHn8xuABLxxCGgpBAP9O7bVw9zyP0F4RffVsuNxQhvtwzN8LvHIr2qIUllmiU151m1/kxZ+4aTDrIole3LdmWjFVaZ/STzceoEUxmRzR31V6LwWADPMPgWKWftBrOmi3A=
Message-ID: <21d7e9970601121402u2d05a073kc677f94b278181c0@mail.gmail.com>
Date: Fri, 13 Jan 2006 09:02:04 +1100
From: Dave Airlie <airlied@gmail.com>
To: Alan Hourihane <alanh@tungstengraphics.com>
Subject: Re: 2.6.15-mm2
Cc: Dave Airlie <airlied@linux.ie>, Ulrich Mueller <ulm@kph.uni-mainz.de>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Brice Goglin <Brice.Goglin@ens-lyon.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1137099813.9711.32.camel@jetpack.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060107052221.61d0b600.akpm@osdl.org>
	 <20060107210413.GL9402@redhat.com> <43C03214.5080201@ens-lyon.org>
	 <43C55148.4010706@ens-lyon.org> <20060111202957.GA3688@redhat.com>
	 <u3bjtogq0@a1i15.kph.uni-mainz.de> <20060112171137.GA19827@redhat.com>
	 <17350.39878.474574.712791@a1i15.kph.uni-mainz.de>
	 <Pine.LNX.4.58.0601122036430.32194@skynet>
	 <1137099813.9711.32.camel@jetpack.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > I've cc'ed Alan Hourihane, but from memory the Intel on-board graphics
> > chips don't advertise the AGP bit on the graphics controllers but work
> > using AGP...
> >
> > I've got an PCIE chipset with Radeon on it, and in that case I could get
> > away without agpgart...
>
> Dave,
>
> You're probably reading too much into that last statement.
>
> I've never seen a pure PCI-e chipset from Intel (i.e. the ones without
> integrated graphics) so that may not be true, but the ones with
> integrated graphics are always treated as AGP based.
>

I'll show you one at xdevconf if I can get there, it has just a PCI-E
root bridge no graphics controller, we still init AGP on it but I
don't think there is any need, however for all the integrated
graphics, even if they don't advertise AGP they do use it which is
DaveJ's problem that he was trying not to load AGP if the AGP was
being advertised..

Dave.
