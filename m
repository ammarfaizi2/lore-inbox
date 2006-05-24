Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbWEXE5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWEXE5r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 00:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWEXE5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 00:57:47 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:24415 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932583AbWEXE5r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 00:57:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ta3iy6+fPOdL0NKOTzTQGbcSstlTJ+6GW9uxf9NgTmnXTfIOdbmbmxmm2vKFXkhw/8b3xLvpOtrDWvq/1IxpvE/9BhfGEIRYmU4ui2NH1o44mqwnMbiu997J3YH9uUY+874Wy/D4ZcL1dqowbAjFy4HsLlhsK97LTeVBZ6xcOZA=
Message-ID: <9e4733910605232157w3afe1ab6vd5aa35fad27562e1@mail.gmail.com>
Date: Wed, 24 May 2006 00:57:46 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, "Dave Airlie" <airlied@linux.ie>
In-Reply-To: <200605240042.46288.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605232324.20876.dhazelton@enter.net>
	 <9e4733910605232121s259e97fdu755e1f2762026e5f@mail.gmail.com>
	 <200605240042.46288.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/06, D. Hazelton <dhazelton@enter.net> wrote:
> I had planned on actually exporting the full, probed capabilities of the
> devices to userspace via sysfs, though I don't know if there is a good way to
> export full DDC or EDID information. Perhaps that should go somewhere
> in /proc?  (I know, the kernel is moving away from information in /proc but
> the sysfs "single setting per file" would mean a lot of files to contain all
> the potential information)

Load an fbdev driver and look in sysfs. fbdev already has the ability
to list the valid modes via the 'modes' parameter. Copy one of those
strings into 'mode' and your more will be set.

> And as you note, licensing is an issue. However, as the kernel is GPL I might
> use DRM as an information source and write that code over again to sidestep
> any licensing issues. (I really don't want to piss off the MIT or BSD people)

But it is very hard to merge DRM and fbdev without touching the fbdev
code and getting things mixed up.  Plus there is no guarantee that BSD
will even use your code if you keep the license clean. Other OS's
don't necessarily like the Linux fbdev model.

-- 
Jon Smirl
jonsmirl@gmail.com
