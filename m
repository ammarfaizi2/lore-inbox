Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVCXVuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVCXVuY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 16:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVCXVuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 16:50:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:60837 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261315AbVCXVuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 16:50:19 -0500
Date: Thu, 24 Mar 2005 13:49:59 -0800
From: Greg KH <greg@kroah.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm2 (patch to fix build error In function `zft_init')
Message-ID: <20050324214958.GA26919@kroah.com>
References: <20050324044114.5aa5b166.akpm@osdl.org> <4242D820.8070801@mesatop.com> <4242E2E1.2060402@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4242E2E1.2060402@mesatop.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 08:55:13AM -0700, Steven Cole wrote:
> Steven Cole wrote:
> >I'm getting the following build error with 2.6.12-rc1-mm2:
> >
> >  CC      init/version.o
> >  LD      init/built-in.o
> >  LD      .tmp_vmlinux1
> >drivers/built-in.o(.init.text+0x4323): In function `zft_init':
> >: undefined reference to `class_device_creat'
> >make: *** [.tmp_vmlinux1] Error 1
> >
> 
> I glanced at the code, and this little patch fixes the problem:

Ick, sorry, that was my fault.  I've applied this patch to my trees,
thanks.

Hm, I wonder how I missed this, I did do a 'make allmodconfig' build to
try to catch this kind of stuff...

thanks,

greg k-h
