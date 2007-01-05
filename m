Return-Path: <linux-kernel-owner+w=401wt.eu-S1161085AbXAEMsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbXAEMsO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 07:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbXAEMsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 07:48:14 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:51961 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161085AbXAEMsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 07:48:13 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Frederik Deweerdt <deweerdt@free.fr>
Subject: Re: [-mm patch] lockdep: possible deadlock in sysfs
Date: Fri, 5 Jan 2007 13:48:19 +0100
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com, maneesh@in.ibm.com, oliver@neukum.name
References: <20070104220200.ae4e9a46.akpm@osdl.org> <20070105121643.GE17863@slug>
In-Reply-To: <20070105121643.GE17863@slug>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701051348.19898.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 5. Januar 2007 13:16 schrieb Frederik Deweerdt:
> This is due to sysfs_hash_and_remove() holding dir->d_inode->i_mutex
> before calling sysfs_drop_dentry() which calls orphan_all_buffers()
> which in turn takes node->i_mutex.

This makes me wonder why it didn't deadlock during my tests.
I am investigating.

	Regards
		Oliver
