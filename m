Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965194AbWEYXs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbWEYXs5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 19:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbWEYXs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 19:48:57 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:3040 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965194AbWEYXs4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 19:48:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TqtQ1OtJVvLUdynGfUCzTcupb+rwEns2HSxZ6D/0Ozzjs67maYcMK+W6UGQv9qIJQBJSTjVBraoH7dsLlwpyauPElLcsyEzkNSjAOAGa4zAAcSHaVjzE9vKitetRZDkieO2705X9WRj/p7lwQImq60ExIJsPQhDokJHkIm4PcrE=
Message-ID: <9e4733910605251648l956a777s781f489d5b4f558f@mail.gmail.com>
Date: Thu, 25 May 2006 19:48:55 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>, "Dave Airlie" <airlied@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <44763B8E.3050200@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <9e4733910605241656r6a88b5d3hda8c8a4e72edc193@mail.gmail.com>
	 <4475007F.7020403@garzik.org> <200605250237.20644.dhazelton@enter.net>
	 <44756E70.9020207@garzik.org>
	 <9e4733910605250704m68235d88lcd8eaedfda5e63cf@mail.gmail.com>
	 <4475C845.5000801@garzik.org>
	 <9e4733910605250837u59ad3881s75a0ed366fa2eefb@mail.gmail.com>
	 <44763B8E.3050200@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/06, Jeff Garzik <jeff@garzik.org> wrote:
> > There is significant architectural difference between the two schemes.
> > Is the base driver an absolute minimal driver that only serves as a
> > switch to route into the other drivers, or does the base driver
> > contain all the common code? I'm in the common code camp, DaveA is in
> > the minimal switch camp.
>
> You are missing that both are the same camp.  It's just different paths
> to get to the same destination.  Common code will inevitably result.

Given that there are 60 fbdev drivers and only 7 DRM drivers. It sure
looks easier to me to declare the fbdev drivers as being the base
driver.  But if you want to spend the time needed to split up 60 fbdev
drivers, go ahead.

But one thing I do not want to see is only splitting the 7 fbdev
drivers that correspond to the DRM ones. The net effect of that will
be to create two different fbdev architectures. If you're going to
split fbdev you have to make the same split to all of them.

-- 
Jon Smirl
jonsmirl@gmail.com
