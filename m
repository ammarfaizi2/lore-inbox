Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVEMSx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVEMSx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVEMSx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:53:57 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:61898 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262478AbVEMSrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:47:08 -0400
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ram <linuxram@us.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, jamie@shareable.org, ericvh@gmail.com,
       7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       smfrench@austin.rr.com, hch@infradead.org
In-Reply-To: <1116003238.6248.367.camel@localhost>
References: <20050511170700.GC2141@mail.shareable.org>
	 <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
	 <1115840139.6248.181.camel@localhost>
	 <20050511212810.GD5093@mail.shareable.org>
	 <1115851333.6248.225.camel@localhost>
	 <a4e6962a0505111558337dd903@mail.gmail.com>
	 <20050512010215.GB8457@mail.shareable.org>
	 <a4e6962a05051119181e53634e@mail.gmail.com>
	 <20050512064514.GA12315@mail.shareable.org>
	 <a4e6962a0505120623645c0947@mail.gmail.com>
	 <20050512151631.GA16310@mail.shareable.org>
	 <E1DWIms-0005nC-00@dorka.pomaz.szeredi.hu>
	 <1115946620.6248.299.camel@localhost> <1115969123.6248.336.camel@localhost>
	 <1115974780.6248.346.camel@localhost>
	 <E1DWWBo-00013Z-00@dorka.pomaz.szeredi.hu>
	 <1116003238.6248.367.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116009860.1444.497.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 May 2005 19:44:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right but this fix disallows fchdir into a directory belonging to
> a different namespace.  And hence would disallow the ability to
> cross mount across namespaces.

A helper can still pass file handles for you, you've changed the
semantics a little (and I'm not clear if there is a need to) but I don't
see it serves any fundamental purpose. Historical experience is that
chroot exiting via fchdir is actually useful


