Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVCaIZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVCaIZp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 03:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVCaIZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 03:25:44 -0500
Received: from moutng.kundenserver.de ([212.227.126.189]:226 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261173AbVCaIZj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 03:25:39 -0500
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: Yves Crespin <crespin.quartz@wanadoo.fr>
Subject: Re: Disable cache disk
Date: Thu, 31 Mar 2005 10:25:31 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <424AA2F0.3090100@wanadoo.fr> <200503301738.39057.linux-kernel@borntraeger.net> <424BA580.10905@wanadoo.fr>
In-Reply-To: <424BA580.10905@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503311025.31391.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yves Crespin wrote:
> Christian Bornträger wrote:
> >On Wednesday 30 March 2005 15:00, Yves Crespin wrote:
> >>1/ is-it possible to *really* be synchronize. I prefer to have a
> >> blocked write() than use cache and get swap!
> >Try to mount with the sync option.
> exactly async and noatime ?

No.  async is exactly the behaviour you dont want. Problem is, the "sync" 
mount option is not available for every file system. At least ext2, ext3, 
and ufs support this option. No idea about other filesystems.


> >>2/ is-it possible to disable cache disk ?
> >
> >your copy tool has to support/use O_DIRECT
>
> is O_DIRECT a POSIX option ?

No it is a Linux extension.

