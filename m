Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbTIJAET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 20:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbTIJAET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 20:04:19 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:3847 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265082AbTIJAES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 20:04:18 -0400
Date: Wed, 10 Sep 2003 02:04:16 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Bernd Schubert <bernd-schubert@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inode generation numbers
Message-ID: <20030910020416.A1603@pclin040.win.tue.nl>
References: <200309092108.37805.bernd-schubert@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200309092108.37805.bernd-schubert@web.de>; from bernd-schubert@web.de on Tue, Sep 09, 2003 at 09:08:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 09:08:37PM +0200, Bernd Schubert wrote:

> for a user space nfs-daemon it would be helpful to get the inode generation 
> numbers. However it seems the fstat() from the glibc doesn't support this, 
> but refering to some google search fstat() from some (not all) other unixes 
> does.
> Does anyone know how to read those numbers from userspace with linux?

For ext2:
The i_generation field of a file can be read and set using
the EXT2_IOC_GETVERSION and EXT2_IOC_SETVERSION ioctls.

