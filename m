Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932634AbVIMMqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbVIMMqs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 08:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbVIMMqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 08:46:47 -0400
Received: from ms001msg.fastwebnet.it ([213.140.2.51]:29636 "EHLO
	ms001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932634AbVIMMqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 08:46:47 -0400
Date: Tue, 13 Sep 2005 14:47:49 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: simrw@sim-basis.de
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 2.6.14-rc1] i386: Correct Pentium optimization
Message-ID: <20050913144749.28794d63@localhost>
In-Reply-To: <3974.192.168.6.50.1126612308.squirrel@simlinux>
References: <3974.192.168.6.50.1126612308.squirrel@simlinux>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.7; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005 13:51:48 +0200 (CEST)
simrw@sim-basis.de wrote:

> -cflags-$(CONFIG_MPENTIUMII)	+= -march=i686 $(call cc-option,-mtune=pentium2)
> -cflags-$(CONFIG_MPENTIUMIII)	+= -march=i686 $(call cc-option,-mtune=pentium3)
> -cflags-$(CONFIG_MPENTIUMM)	+= -march=i686 $(call cc-option,-mtune=pentium3)
> -cflags-$(CONFIG_MPENTIUM4)	+= -march=i686 $(call cc-option,-mtune=pentium4)
> +cflags-$(CONFIG_MPENTIUMII)	+= $(call cc-option,-march=pentium2,-march=i686)
> +cflags-$(CONFIG_MPENTIUMIII)	+= $(call cc-option,-march=pentium3,-march=i686)
> +cflags-$(CONFIG_MPENTIUMM)	+= $(call cc-option,-march=pentium-m,-march=i686)
> +cflags-$(CONFIG_MPENTIUM4)	+= $(call cc-option,-march=pentium4,-march=i686)


I'm not sure that it is safe, read this:

http://groups.google.it/group/linux.kernel/browse_frm/thread/89467f7aa9963d4f/b4575e40eecc713a?lnk=st&q=march%3Dpentium4+mtune+group:linux.kernel&rnum=1&hl=it#b4575e40eecc713a

-- 
	Paolo Ornati
	Linux 2.6.14-rc1 on x86_64
