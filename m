Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVDMN2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVDMN2I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 09:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVDMN2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 09:28:08 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:48467 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261346AbVDMN2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 09:28:05 -0400
Date: Wed, 13 Apr 2005 15:27:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Toralf Lund <toralf@procaptura.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: insmod segfault in pci_find_subsys()
Message-ID: <20050413132755.GA8236@mars.ravnborg.org>
References: <423A9B65.1020103@procaptura.com> <20050318170709.GD14952@kroah.com> <42496309.3080007@procaptura.com> <20050413071233.GB25581@kroah.com> <425CFBDA.9040301@procaptura.com> <1113390818.6275.52.camel@laptopd505.fenrus.org> <425D0736.1080105@procaptura.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425D0736.1080105@procaptura.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 01:49:10PM +0200, Toralf Lund wrote:
> > 
> >
> Yes. As I've (also) already said elsewhere, I knew that, really. The 
> current build setup fails to do this partly for historical reasons, 
> partly because the driver also supports different OSes. (And is still 
> expected to build correctly with Linux 2.4, not just 2.6.)

Following trick works with both 2.4 and 2.6:

makefile:
all:
	$(MAKE) -C Kernel_src_path SUBDIRS=$(PWD) modules

Makefile:

obj-m := mymodule.o

It obtains CFLAGS as expected etc.
People seems to do their best to avoid such a simple setup :-(

	Sam
