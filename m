Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267429AbTCEPrf>; Wed, 5 Mar 2003 10:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbTCEPrf>; Wed, 5 Mar 2003 10:47:35 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:41722 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S267429AbTCEPre>;
	Wed, 5 Mar 2003 10:47:34 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15974.7817.474141.453202@gargle.gargle.HOWL>
Date: Wed, 5 Mar 2003 16:58:01 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to boot a raw kernel image :??
In-Reply-To: <3E661C1D.904@zytor.com>
References: <20021129132126.GA102@DervishD>
	<3DF08DD0.BA70DA62@gmx.de>
	<b453er$qo7$1@cesium.transmeta.com>
	<15974.6329.574794.597753@gargle.gargle.HOWL>
	<3E661C1D.904@zytor.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
 > Mikael Pettersson wrote:
 > > 
 > > FWIW, I still use bzdisk images frequently, and the 1MB limit really
 > > is a serious problem for 2.5 kernels, and 2.4 kernels build with gcc-3.
 > > I'm currently using a patched kernel where `make bzdisk' invokes a
 > > user-specified script, which in my case goes roughly like:
 > > 
 > 
 > If you get my nobootsect patch:
 > 
 > ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/nobootsect-2.5.63-bk7-1.diff
 > 
 > ... you will find something similar, but a bit more fleshed out.
 > 
 > This is the patch I'm trying to get Linus to accept.

That's similar to what you posted to LKML a while ago, and
it has the limitations of requiring mountable /dev/fd0, which
needs a magic entry in /etc/fstab ("user" privs, not "owner"),
and MS-DOS FS support in the kernel used for the build.

Those are the limitations I want to avoid. Do put this in a script
in the kernel, but please allow the user to override it via $PATH.

/Mikael
