Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317917AbSHHTx0>; Thu, 8 Aug 2002 15:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317918AbSHHTx0>; Thu, 8 Aug 2002 15:53:26 -0400
Received: from ns1.weccusa.org ([207.1.28.170]:9201 "EHLO trabajo")
	by vger.kernel.org with ESMTP id <S317917AbSHHTxZ>;
	Thu, 8 Aug 2002 15:53:25 -0400
Date: Thu, 8 Aug 2002 14:56:58 -0500
From: "Bryan K. Walton" <thisisnotmyid@tds.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with 1gb ddr memory sticks on linux
Message-ID: <20020808195658.GO16225@weccusa.org>
References: <20020808160456.GI16225@weccusa.org> <1028828840.28883.43.camel@irongate.swansea.linux.org.uk> <20020808163952.GJ16225@weccusa.org> <1028836012.28883.61.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028836012.28883.61.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks to Alan, Mark, and everyone else who offered advice on fixing my
problem with my bios and large memory sticks.  I rewrote the /proc/mtrr
and everything is speedy now!

Thank you!
Bryan

On Thu, 2002-08-08 at 19:40, Mark Hahn wrote:
> > echo "base=0x00000000 size=0x60000000 type=write-back" >/proc/mtrr
 
> > 
> > should override the BIOS setting and make your machine speed up.
> 
> don't mtrrs still have to be a power of two in size?
> ie, he'd need two for 1024+256...

You are correct he should add one starting at 0 for 1Gb and one at 1Gb
for 256Mb - my error.
