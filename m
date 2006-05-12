Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWELDRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWELDRr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 23:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWELDRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 23:17:47 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:45470 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750877AbWELDRr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 23:17:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QQwNXf3qKu6xffm3Ikjf/miZI2WhcjJPQTsQq31z69utbCY8okXEI0qZlfXdC3a0TgF5QJkXaMItdS3lJKS7tXXEs5s5RhmudctGgxbhNfTquv72mbUIerH/mOvd2wEvj2OSq8ZnuS7/Mb1PEogNi5v6X6UoLtlS3VZATynWLRE=
Message-ID: <9e4733910605112017u428c04cdm2ff40b53785db09c@mail.gmail.com>
Date: Thu, 11 May 2006 23:17:46 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: SecurityFocus Article
Cc: "Ed White" <ed.white@libero.it>, ML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0605111140030.3833@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060511143440.23517.qmail@securityfocus.com>
	 <Pine.LNX.4.61.0605111140030.3833@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/06, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
> Sorry, the X-server is too large to go into the kernel. It's
> a lot easier to modify the boot-loader to set the D_LCK bit
> if the security compromise turns out to be real.

The X server doesn't need to go into the kernel, only a very tiny
portion of it needs to go in. But X blindly pursues the idea of total
platform independence which means it ignores many of the services
offer by the Linux kernel and reimplements them in user space. This is
because the BSDs are missing many things that Linux supports.

I just love the idea of 2.4M lines of X code that opens network
sockets needlessly running as root. Top it off with 1,300 unfixed
Coverity hits, http://scan.coverity.com/. But what fun is life if you
don't live a little dangerously. If you want ideas on how to fix X to
not run as root read,
http://people.freedesktop.org/~jonsmirl/graphics.html

Of course DaveA will chime in and say that they are working on fixing
things to use the Linux kernel. This is good and I am glad it is being
done, I just worry that it will get finished sometime around 2014.

-- 
Jon Smirl
jonsmirl@gmail.com
