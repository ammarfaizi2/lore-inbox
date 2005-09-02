Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030641AbVIBCIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030641AbVIBCIg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 22:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030648AbVIBCIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 22:08:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030641AbVIBCIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 22:08:35 -0400
Date: Thu, 1 Sep 2005 19:06:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
Message-Id: <20050901190655.345914ba.akpm@osdl.org>
In-Reply-To: <1125626219l.6072l.0l@werewolf.able.es>
References: <fa.hqupr0d.1u3af35@ifi.uio.no>
	<4317AD4D.6030001@reub.net>
	<1125626219l.6072l.0l@werewolf.able.es>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> 
> On 1/09/2005 10:58 a.m., Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm1/
> > 
> > - Included Alan's big tty layer buffering rewrite.  This breaks the build on
> >   lots of more obscure character device drivers.  Patches welcome (please cc
> >   Alan).
> > 
> 
> I have problems with udev and latest -mm.
> 2.6.13 boots fine, but 2.6.13-mm1 blocks when starting udev.
> System is Mandriva Cooker. As cooker, things are changing fast (initscripts,
> udev, etc), but the fact is that with the same setup, plain .13 boots
> and -mm1 blocks. Udev is 068 version.
> 
> Any idea about what can be the reason ?
> 

There's some suspect locking in the /proc/devices seq_file conversion code.

Could you revert convert-proc-devices-to-use-seq_file-interface-fix.patch
then convert-proc-devices-to-use-seq_file-interface.patch?

