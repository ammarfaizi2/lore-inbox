Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVDDRSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVDDRSJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 13:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVDDRSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 13:18:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44237 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261294AbVDDRSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 13:18:05 -0400
Subject: Re: [PATCH] configfs, a filesystem for userspace-driven kernel
	object configuration
From: Arjan van de Ven <arjan@infradead.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>, viro@zenii.uk.linux.org
In-Reply-To: <20050403195728.GH31163@ca-server1.us.oracle.com>
References: <20050403195728.GH31163@ca-server1.us.oracle.com>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 19:17:59 +0200
Message-Id: <1112635079.6270.68.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-03 at 12:57 -0700, Joel Becker wrote:
> Folks,
> 	I humbly submit configfs.  With configfs, a configfs
> config_item is created via an explicit userspace operation: mkdir(2).
> It is destroyed via rmdir(2).  The attributes appear at mkdir(2) time,
> and can be read or modified via read(2) and write(2).  readdir(3)
> queries the list of items and/or attributes.
> 	The lifetime of the filesystem representation is completely
> driven by userspace.  The lifetime of the objects themselves are managed
> by a kref, but at rmdir(2) time they disappear from the filesystem.

does that mean you rmdir a non-empty directory ??


