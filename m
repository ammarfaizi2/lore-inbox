Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266188AbUHHTSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUHHTSi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 15:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUHHTSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 15:18:38 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:945 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S266188AbUHHTS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 15:18:27 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Andi Kleen <ak@muc.de>
Subject: Re: block layer sg, bsg
Date: Sun, 8 Aug 2004 15:18:25 -0400
User-Agent: KMail/1.6.2
Cc: "David S. Miller" <davem@redhat.com>, yoshfuji@linux-ipv6.org,
       jgarzik@pobox.com, axboe@suse.de, linux-kernel@vger.kernel.org
References: <20040804191850.GA19224@havoc.gtf.org> <200408060303.40261.phillips@arcor.de> <20040806150416.GA90652@muc.de>
In-Reply-To: <20040806150416.GA90652@muc.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408081518.25522.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 August 2004 11:04, Andi Kleen wrote:
> > Somewhere I got the idea that if a structure is declared with attribute
> > PACKED, gcc will generate alignment-independent code (e.g., access each
> > field byte by byte) on alignment-restricted architectures.  So if what I
> > imagine about gcc is true, what issues remain?  These structs have to be
> > declared packed anyway and with fixed field sizes, or the layout will
> > vary across architectures.
>
> With packed things should be fine for x86-64/i386. However it may
> generate bad code for other architectures.

That's the question.  From talking to gcc developers in the former Cygnus 
office, it's thought that alignment-restricted architectures are supposed to 
do bytewise access (or equivalent) to PACKED fields, but nobody was sure if 
every architecture implements this, or even if it's the formally defined 
behavior for PACKED.  That's a subset of GCC developers of course.

As far as I can see, if PACKED doesn't work this way on all architectures then 
it's broken and needs to be fixed.

Regards,

Daniel
