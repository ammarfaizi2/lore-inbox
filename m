Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbTDGMAB (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263390AbTDGMAB (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:00:01 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30867
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263389AbTDGMAA (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:00:00 -0400
Subject: Re: [PATCH] new syscall: flink
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olivier Galibert <galibert@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030407091120.GA50075@dspnet.fr.eu.org>
References: <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org>
	 <b6qruf$elf$1@cesium.transmeta.com> <b6r9cv$jof$1@news.cistron.nl>
	 <20030407081800.GA48052@dspnet.fr.eu.org>
	 <20030407043555.G13397@devserv.devel.redhat.com>
	 <20030407091120.GA50075@dspnet.fr.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049713992.2965.23.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Apr 2003 12:13:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-07 at 10:11, Olivier Galibert wrote:
> On Mon, Apr 07, 2003 at 04:35:56AM -0400, Jakub Jelinek wrote:
> > There is at most one path associated with an opened file - d_path on
> > file->f_dentry. If a fd has no path, don't permit flink().
> > Alternatively, flink() could have 3 arguments, 2 like link and an opened
> > fd, which would atomically do if fd describes the same object as buf,
> > link buf to newname.
> 
> That breaks one of the main uses, creating with open a temporary file
> in /tmp, unlinking it, then later hooking it up somewhere else in the
> filesystem.

/tmp is normally on another file system so its not going to work anyway

