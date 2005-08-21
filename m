Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVHUVpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVHUVpQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVHUVox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:44:53 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:6606 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751198AbVHUVoj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:44:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LtS5MiCJlvtMgGgA3xthXEZsHqaVrjdPDA+2HujAmUojqcrJwrnuMTpuE1/wI/d/xGkllyPc2Z8iE1Q33a5yQAwi5flKGuWVgzRS22dPC31mA4RSQe1auvtw+EhG6bOVTmbOQpom8JjbjG9hn2nHvMrV8+Yq+ZPGzfibppchWY8=
Message-ID: <40f323d005082109303c0865a3@mail.gmail.com>
Date: Sun, 21 Aug 2005 18:30:50 +0200
From: Benoit Boissinot <bboissin@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: 2.6.13-rc6-mm1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/05, Andrew Morton <akpm@osdl.org> wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm1/
> 
> - Lots of fixes, updates and cleanups all over the place.
> 
> - If you have the right debugging options set, this kernel will generate
>   a storm of sleeping-in-atomic-code warnings at boot, from the scsi code.
>   It is being worked on.
> 
> 
> Changes since 2.6.13-rc5-mm1:
> [...]
> +gregkh-driver-sysfs-strip_leading_trailing_whitespace.patch
> [...]


it broke loading of firmware for me.(dmesg was flooded with
"firmware_loading_store:  unexpected value (0)")

firmware.agent uses echo so there is a trailing newline. If i changes
firmware.agent to uses echo -n it works correctly.

Is this a bug or the correct behaviour ?

regards,

Benoit
