Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVA2XQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVA2XQe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVA2XQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:16:34 -0500
Received: from mproxy.gmail.com ([216.239.56.244]:53928 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261592AbVA2XQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:16:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DpaGNxKqkBlWoVEOmOKDkGLImxfgyxM4RXGDartjmiVSsMSAOElvEwcshOvr9QWRvHFGDIeS9RYn2hKOnUQmEnVEbY4SZm4+aZ5qJ5uePMv0Ie5laULVzLcJ2EddVt+i4b8/h1AG+hoWM9jpCdJ8hPQKarsli/f4sBU9/xTYxsY=
Message-ID: <21d7e99705012915164660cd20@mail.gmail.com>
Date: Sun, 30 Jan 2005 10:16:30 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: DRI (was Re: OpenOffice crashes due to incorrect access permissions on /dev/dri/card*)
Cc: Parag Warudkar <kernel-stuff@comcast.net>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Jon Smirl <jonsmirl@gmail.com>, ee21rh@surrey.ac.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <1107032714.24676.48.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <pan.2005.01.29.10.44.08.856000@surrey.ac.uk>
	 <E1CurmR-0000H8-00@calista.eckenfels.6bone.ka-ip.net>
	 <pan.2005.01.29.12.49.13.177016@surrey.ac.uk>
	 <pan.2005.01.29.13.02.51.478976@surrey.ac.uk>
	 <9e473391050129112525f4947@mail.gmail.com>
	 <1107030966.24676.28.camel@krustophenia.net>
	 <20050129204036.GA1750@gallifrey> <41FBF8A0.6000708@comcast.net>
	 <1107032714.24676.48.camel@krustophenia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> No, XAA is normally used for 2D acceleration.  This is hardware
> accelerated but doesn't use DRI, X does 2D accel by talking directly to
> the hardware without the kernel's involvement.
> 
well not totally true, X on radeon/r200/r300 cards needs the DRM to
load the microcode for the command processor, this enables some major
speedups in the 2D code (it still talk direct to the card, but needs
the CP loading...) but X runs as root so it has no worries opening the
device...

the issue is with using having the perms set to 0660 since the drm
started supporting sysfs and udev... normally X created the dri
devices and set the permissions to what was in the X config, normally
666.... or 660 with a dri group...

Dave.
