Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVEYL4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVEYL4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 07:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVEYL4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 07:56:18 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:14346 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262227AbVEYL4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 07:56:11 -0400
Date: Wed, 25 May 2005 07:56:06 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: van <van.wanless@eqware.net>, linux-kernel@vger.kernel.org
Subject: Re: File I/O from within a driver
Message-ID: <20050525115605.GA17005@tuxdriver.com>
Mail-Followup-To: Brian Gerst <bgerst@didntduck.org>,
	van <van.wanless@eqware.net>, linux-kernel@vger.kernel.org
References: <2005524221531.650853@Oz> <42941017.3090707@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42941017.3090707@didntduck.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 01:41:43AM -0400, Brian Gerst wrote:
> van wrote:

> >the media file.  The structure of media files is complex and I'd rather 
> >the calling application didn't need to have any knowledge of that 
> >structure.  But how can the driver do the necessary read() operations?

> The best way is to mmap() the file into memory, then pass the address to 
> the driver.

That probably is a good way.  An alternative might be for the driver
to pass some paramaterized knowledge of the file structure back to
the userland app.  That would prevent the userland app from having
to know as much a priori, but it may be difficult to figure-out how
to describe the media files' structure in a paramaterized way.

YMMV... :-)

John
-- 
John W. Linville
linville@tuxdriver.com
