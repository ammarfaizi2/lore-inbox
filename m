Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbUK3Na5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbUK3Na5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 08:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbUK3Na4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 08:30:56 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50836 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262084AbUK3NaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 08:30:09 -0500
Date: Tue, 30 Nov 2004 14:26:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, ecki-news2004-05@lina.inka.de,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with ioctl command TCGETS
Message-ID: <20041130132619.GD4670@openzaurus.ucw.cz>
References: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net> <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu> <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The set-get is supposed to be used for queries, too? The size of value is
> > > only used for the get case to describe the buffer length in that case?
> > > because otherwise the set-get case may require a short value in and a large
> > > answer structure out.
> > 
> > You misunderstand the motivation.  This is to get/set small compact
> > parameters, not huge structures or big data.  Think get/setsockopt().
> 
> Think read(2)/write(2).  We already have several barfbags too many,
> and that includes both ioctl() and setsockopt().  We are stuck with
> them for compatibility reasons, but why the hell would we need yet
> another one?

Passing structure using read/write is evil, because there's nowhere to hook 
32/64 bit translation.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

