Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVBVEmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVBVEmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 23:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVBVEmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 23:42:14 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:60133 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262202AbVBVEmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 23:42:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=RduWI06Nn9XmgPHbB8PB/65S38aMydR+m8C05KUDcjrA2eBymt+zr8BZv01uT6s6EVjzf0zPItOpFg7gAsFzTNl+BXlX6aOtcl40JlQxKdZBf8E3E+c87MwVw3dlPniEWENLiluk5fy6j6ilwnMRkQRlpVUrI+qZ060jBlU0OMU=
Message-ID: <9e473391050221204215a079e1@mail.gmail.com>
Date: Mon, 21 Feb 2005 23:42:09 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: POSTing of video cards (WAS: Solo Xgl..)
Cc: Dave Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net,
       xorg@lists.freedesktop.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1109041968.5412.63.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0502201049480.18753@skynet>
	 <4218BAF0.3010603@tungstengraphics.com>
	 <21d7e997050220150030ea5a68@mail.gmail.com>
	 <9e4733910502201542afb35f7@mail.gmail.com>
	 <1108973275.5326.8.camel@gaston>
	 <9e47339105022111082b2023c2@mail.gmail.com>
	 <1109019855.5327.28.camel@gaston>
	 <9e4733910502211717116a4df3@mail.gmail.com>
	 <1109041968.5412.63.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005 14:12:48 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> It's up to each driver to detect wether it's card need to be POSTed or
> not. Anything else would mean infinite breakage.

Your approach is that it is a per driver problem. I was taking a
different tack and looking at it as a BIOS deficiency that should be
compensated for. There is already code in the kernel for identifying
the boot video device. I was working on the assumption that all PCI
based, VGA class hardware that is not the boot device needs to be
posted. And that the posting should occur before the drivers are
loaded. In order words the BIOS should have provided initialized
hardware but since it didn't we can apply a fixup in the PCI driver. I
also suspect there may be SCSI disk controller cards that need the
same procedure.

I have no strong opinions on how to fix the post problem, I just want
to make sure the problem is fully discussed by the relevant people and
a consensus solution is achieved. I'm not sure that all of the core
kernel developers that might be impacted by this have considered all
of the options. I would like to try and get a consensus design and
avoid reimplementing everything ten times.

-- 
Jon Smirl
jonsmirl@gmail.com
