Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUIWUnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUIWUnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266566AbUIWUmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:42:33 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:26641 "EHLO smtp.sys.beep.pl")
	by vger.kernel.org with ESMTP id S266274AbUIWUY4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:24:56 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: Re: external modules documentation
Date: Thu, 23 Sep 2004 22:24:50 +0200
User-Agent: KMail/1.7
Cc: sam@ravnborg.org
References: <20040918112900.GA22428@lst.de>
In-Reply-To: <20040918112900.GA22428@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409232224.50234.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 of September 2004 13:29, Christoph Hellwig wrote:
> Sam,
>
> is there any reason your patch from June still isn't merged?
>
[...]
> +Prepare the kernel for building external modules
> +------------------------------------------------
> +When building external modules the kernel is expected to be prepared.
> +This includes the precense of certain binaries, the kernel configuration
> +and the symlink to include/asm.
> +To do this a convinient target is made:
> +
> + make modules_prepare
> +
> +For a typical distribution this would look like the follwoing:
> +
> + make modules_prepare O=/lib/modules/linux-<kernel version>/build
Tthis means that one, unmodified source tree is _not_ usable for multiple 
architectures. You can't use the same, prepared sources and for example 
create noarch.rpm or burn on cd and then use for external modules building on 
different architectures.

We are using this:
http://cvs.pld-linux.org/cgi-bin/cvsweb/SOURCES/linux-kbuild-extmod.patch?rev=1.2
to get external modules working for multiple archs with the same sources:
http://cvs.pld-linux.org/cgi-bin/cvsweb/SPECS/template-kernel-module.spec?rev=1.14

-- 
Arkadiusz Mi¶kiewicz                    PLD/Linux Team
http://www.t17.ds.pwr.wroc.pl/~misiek/  http://ftp.pld-linux.org/
