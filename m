Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbUK1MSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbUK1MSE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 07:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbUK1MSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 07:18:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25990 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261446AbUK1MSC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 07:18:02 -0500
Date: Sun, 28 Nov 2004 12:18:00 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: ecki-news2004-05@lina.inka.de, linux-kernel@vger.kernel.org
Subject: Re: Problem with ioctl command TCGETS
Message-ID: <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk>
References: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net> <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 12:22:03PM +0100, Miklos Szeredi wrote:
> > The set-get is supposed to be used for queries, too? The size of value is
> > only used for the get case to describe the buffer length in that case?
> > because otherwise the set-get case may require a short value in and a large
> > answer structure out.
> 
> You misunderstand the motivation.  This is to get/set small compact
> parameters, not huge structures or big data.  Think get/setsockopt().

Think read(2)/write(2).  We already have several barfbags too many,
and that includes both ioctl() and setsockopt().  We are stuck with
them for compatibility reasons, but why the hell would we need yet
another one?
