Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267407AbTA1RN3>; Tue, 28 Jan 2003 12:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbTA1RN3>; Tue, 28 Jan 2003 12:13:29 -0500
Received: from waste.org ([209.173.204.2]:46816 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267407AbTA1RN2>;
	Tue, 28 Jan 2003 12:13:28 -0500
Date: Tue, 28 Jan 2003 11:22:36 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Stanley Yee <SYee@snapappliance.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sendfile support in linux
Message-ID: <20030128172236.GR3186@waste.org>
References: <057889C7F1E5D61193620002A537E8690B4387@NCBDC>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <057889C7F1E5D61193620002A537E8690B4387@NCBDC>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 05:45:20PM -0800, Stanley Yee wrote:
> I'm trying to find out more about sendfile(2).  So far, from what I've
> gathered, it sounds like the requirements for it are (please correct me if
> I'm wrong):
> 
> 1.  A kernel with sendfile support (i.e. 2.4.X)
> 2.  A network card capable of doing the TCP checksum in the hardware
> 3.  The application must support sendfile 

Don't confuse sendfile with zerocopy. You generally need to use
sendfile to take advantage of zerocopy, but you can still get
advantages from sendfile without having hardware support, mainly in
terms of reducing syscall overhead. And without sendfile, you can
still get performance benefits from zerocopy..
 
> Do you know what applications support zerocopy (sendfile)?  I noticed that a
> zerocopy NFS patch was added to the 2.5.x tree.  Does the 2.4.X NFS daemon
> support zerocopy?  Does samba support zerocopy and if so what version?

Sendfile is mostly used by webservers. You can check the Samba
changelogs for when they started using sendfile. And 2.4 NFS doesn't
use zerocopy, AFAIK.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
