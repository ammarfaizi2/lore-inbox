Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbVHEIhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbVHEIhE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 04:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbVHEIhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 04:37:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64176 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262916AbVHEIes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 04:34:48 -0400
Subject: Re: [PATCH 00/14] GFS
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: David Teigland <teigland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
In-Reply-To: <Pine.LNX.4.61.0508051026540.26367@yvahk01.tjqt.qr>
References: <20050802071828.GA11217@redhat.com>
	 <1122968724.3247.22.camel@laptopd505.fenrus.org>
	 <20050805071415.GC14880@redhat.com>
	 <Pine.LNX.4.61.0508051026540.26367@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 10:34:32 +0200
Message-Id: <1123230872.3239.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 10:28 +0200, Jan Engelhardt wrote:
> >The gfs2_disk_hash() function and the crc table on which it's based are a
> >part of gfs2_ondisk.h: the ondisk metadata specification.  This is a bit
> >unusual since gfs uses a hash table on-disk for its directory structure.
> >This header, including the hash function/table, must be included by user
> >space programs like fsck that want to decipher a fs, and any change to the
> >function or table would effectively make the fs corrupted.  Because of
> >this I think it's best for gfs to keep it's own copy as part of its ondisk
> >format spec.
> 
> Tune the spec to use kernel and libcrc32 tables and bump the version number of 
> the spec to e.g. GFS 2.1. That way, things transform smoothly and could go out 
> eventually at some later date.

afaik the tables aren't actually different. So no need to bump the spec!

