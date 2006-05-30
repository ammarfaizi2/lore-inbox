Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWE3WNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWE3WNc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWE3WNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:13:32 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:50969 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932521AbWE3WNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:13:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c/eniYeeY1hmiXoduZftcYem/dn1reqJHO4avH9qXNaDMrErWXWyvN038irHh6SE9oDavveuvjTuvvX7oPxVJx5QuuxUxCzsqDfIFhbzZhNAgVRvWtCnWtS60eUZZTMQNVkoS7kHvxAAxSi8a1jyPpL2PREmzd3nKjsf4xxfKwc=
Message-ID: <9e4733910605301513i1ee986c3gd221e8ce586ab471@mail.gmail.com>
Date: Tue, 30 May 2006 18:13:20 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "David Lang" <dlang@digitalinsight.com>, "Dave Airlie" <airlied@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <447CBEC5.1080602@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605272245.22320.dhazelton@enter.net>
	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com>
	 <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz>
	 <447CBEC5.1080602@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> A framebuffer driver can be faster than vgacon.  Scrolling is also smooth
> even for vesafb because of a new scrolling method (pan_redraw) introduced
> sometime in 2.6.10.  I don't know about less cpu required, that's probably
> true.

To put this in perspective all of those numbers are drawing screens
way faster than your monitor refresh rate so the text isn't visible.

Highest speed where you could actually see the data, assuming that you
can read at 70 FPS...
3229 lines / 25 lines per screen / 70Hz refresh = 1.85s
3229 lines / 50 lines per screen / 70Hz refresh = 0.92s

But faster code in fbdev is good since it lowers the overall CPU load.

I would like to see fbdev acceleration unified with the other drivers
(DRM/X) so that a single state is maintained in the hardware.

-- 
Jon Smirl
jonsmirl@gmail.com
