Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291930AbSBATnl>; Fri, 1 Feb 2002 14:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291926AbSBATnc>; Fri, 1 Feb 2002 14:43:32 -0500
Received: from [24.64.71.161] ([24.64.71.161]:4339 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S291928AbSBATnV>;
	Fri, 1 Feb 2002 14:43:21 -0500
Date: Fri, 1 Feb 2002 12:43:00 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
Message-ID: <20020201124300.G763@lynx.adilger.int>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <a3enf3$93p$1@cesium.transmeta.com>; from hpa@zytor.com on Fri, Feb 01, 2002 at 10:40:35AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 01, 2002  10:40 -0800, H. Peter Anvin wrote:
> Anything that is meant to be a server really pretty much needs an
> enthropy generator these days.  We really should push vendors to
> provide it (together with serial console firmware and other "well,
> duh" things rackmount servers should have as a matter of course.)

Well, all of the Intel i8XX chipsets have a harware RNG I believe.
There are even tools available to use them (gkernel.sf.net), but
it is not fed into the /dev/random entropy pool by default, and I
doubt that these tools are available with any distro.  At the
time, this decision was made because it is hard to determine what
the actual entropy of this device is.

Maybe, i8XX hardware RNG should feed the /dev/random entropy pool
directly if you enable the chipset support (with an option to turn
it off if you want to use the user-space tools or a separate RNG),
so that people get the benefits of the h/w RNG without having to
install another tool (which they won't know about)?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

