Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbUKMGKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbUKMGKi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 01:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUKMGKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 01:10:38 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:61641 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261848AbUKMGKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 01:10:32 -0500
Date: Sat, 13 Nov 2004 06:10:30 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Adrian Bunk <bunk@stusta.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: kconfig/build question..
In-Reply-To: <20041112184005.GH2249@stusta.de>
Message-ID: <Pine.LNX.4.58.0411130608440.21588@skynet>
References: <Pine.LNX.4.58.0411100110170.1637@skynet>
 <Pine.LNX.4.61.0411101253460.17266@scrub.home> <20041112184005.GH2249@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I dislike this solution.
>
> consider:
> AGP=n
> DRM=y
>
> If the user then adds modular AGP to his kernel this will cause DRM=m
> which might cause problems if he tries to use these modules.

This is exactly what we want to happen, if AGP is there, DRM should use it
no matter what, and if AGP is a module, DRM has to be... it isn't pretty
maybe but I think the DRM-AGP relationship is rather complicated, I'm
probably going to add some output to the drm init string to say whether it
knows about AGP or not ...

Dave.


-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

