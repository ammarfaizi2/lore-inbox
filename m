Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269075AbUICPWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269075AbUICPWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269515AbUICPSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:18:11 -0400
Received: from the-village.bc.nu ([81.2.110.252]:16788 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269366AbUICPQn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:16:43 -0400
Subject: Re: Getting full path from dentry in LSM hooks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kristian =?ISO-8859-1?Q?S=F8rensen?= <ks@cs.aau.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       umbrella-devel@lists.sourceforge.net
In-Reply-To: <41385FA5.806@cs.aau.dk>
References: <41385FA5.806@cs.aau.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1094220870.7975.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 03 Sep 2004 15:14:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-03 at 13:12, Kristian Sørensen wrote:
> I have a short question, concerning how to get the full path of a file 
> from a LSM hook.

The full path or a full path. It may have several. They may also have
changed under you. 

> Can some one reveal the trick to get the full path nomater if the 
> filesystem is root or mounted elsewhere in the filesystem?

You can get the namespace and the name within that namespace that
represents at least one of the names of the file within the vfs layer
(this is what the VFS itself uses for the struct nameidata).

There may be multiple links to a file, it may be mounted in multiple
places and someone on a seperate NFS server may have moved it while you
are thinking about it.

