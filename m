Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUK1NMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUK1NMD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 08:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUK1NMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 08:12:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3469 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261234AbUK1NMB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 08:12:01 -0500
Date: Sun, 28 Nov 2004 13:11:59 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Tomas Carnecky <tom@dbservice.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, ecki-news2004-05@lina.inka.de,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with ioctl command TCGETS
Message-ID: <20041128131159.GC26051@parcelfarce.linux.theplanet.co.uk>
References: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net> <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu> <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk> <41A9CD78.1050002@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A9CD78.1050002@dbservice.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 02:07:04PM +0100, Tomas Carnecky wrote:
> >Think read(2)/write(2).  We already have several barfbags too many,
> >and that includes both ioctl() and setsockopt().  We are stuck with
> >them for compatibility reasons, but why the hell would we need yet
> >another one?
> 
> And what's the option? So without ioctl, how would you reaplace this:
> ioctl(cdrom_fd, CDROMEJECT, 0)?

Which part of "we are stuck with them" is not clear enough?  If you insist
on using the same descriptor for data and for out-of-band mess - no, you
can't get anything saner.  If you do not, you can; it's that simple...
