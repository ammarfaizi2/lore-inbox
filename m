Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbUK1J7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbUK1J7d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 04:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUK1J7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 04:59:33 -0500
Received: from rev.193.226.233.139.euroweb.hu ([193.226.233.139]:63201 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261420AbUK1J7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 04:59:32 -0500
To: viro@parcelfarce.linux.theplanet.co.uk
CC: oebilgen@uekae.tubitak.gov.tr, linux-kernel@vger.kernel.org
In-reply-to: <20041128003901.GS26051@parcelfarce.linux.theplanet.co.uk>
	(message from Al Viro on Sun, 28 Nov 2004 00:39:01 +0000)
Subject: Re: Problem with ioctl command TCGETS
References: <20041128002044.CE13839877@uekae.uekae.gov.tr> <20041128003901.GS26051@parcelfarce.linux.theplanet.co.uk>
Message-Id: <E1CYLpf-0001VQ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 28 Nov 2004 10:59:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 1. Is it nice to break _IO macros?
> 
> There is nothing nice about ioctls.

On the subject of ioctls:  what about a replacement syscall:

 /** 
  * Getting and setting file parameters safely (ioctl done right)
  * 
  * @fd     file descriptor
  * @param  name of the parameter to get/set
  * @dir    direction flag indicating either get, set, or set-get
  * @value  value to set parameter to (set) or store current value into (get)
  * @size   size of value
  */
 int fparam(int fd, const char *param, int dir, void *value, size_t size);

I know it's been talked about in the past.  Is anyone interested?

Miklos

