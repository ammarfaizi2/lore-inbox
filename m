Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293393AbSCFJMO>; Wed, 6 Mar 2002 04:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293379AbSCFJMF>; Wed, 6 Mar 2002 04:12:05 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:1030 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S293381AbSCFJLt>; Wed, 6 Mar 2002 04:11:49 -0500
Date: Wed, 6 Mar 2002 10:14:20 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
To: James Curbo <jcurbo@acm.org>
cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: a couple of USB related Oopses
In-Reply-To: <20020306050349.GA1152@carthage>
Message-ID: <Pine.LNX.4.21.0203061007220.31619-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, James Curbo wrote:

> Ah, I tried it with 2.5.6-pre2 and usb-uhci.. still got a panic, when I
> tried to print to the printer (which is what I was doing before too) 
> Also, got these in my kernel log...
> 
> usb-uhci.c: ENXIO 80000200, flags 0, urb c1523ac0, burb c1523a40

Apparently there were several reports of such ENXIO errors recently
triggered by a spinlock issue in hid-core.c - IIRC you have an usb-mouse
connected and input loaded as well. If so, this might solve it:

<http://marc.theaimsgroup.com/?l=linux-usb-devel&amp;m=101523276704203&amp;w=2>

Martin

