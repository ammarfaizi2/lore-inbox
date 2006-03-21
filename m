Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751685AbWCUUHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbWCUUHz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWCUUHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:07:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40650 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751497AbWCUUHy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:07:54 -0500
Date: Tue, 21 Mar 2006 20:07:50 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Phillip Lougher <phillip@lougher.org.uk>,
       "unlisted-recipients: no To-header on input <;, Jeff Garzik" 
	<jeff@garzik.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
Message-ID: <20060321200750.GH27946@ftp.linux.org.uk>
References: <20060317124310.GB28927@wohnheim.fh-wedel.de> <441ADD28.3090303@garzik.org> <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk> <441AF118.7000902@garzik.org> <20060319163249.GA3856@ucw.cz> <4420236F.80608@lougher.demon.co.uk> <20060321161452.GG27946@ftp.linux.org.uk> <44204F25.4090403@lougher.org.uk> <20060321191144.GB3929@elf.ucw.cz> <44205C1A.4040408@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44205C1A.4040408@lougher.demon.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 08:03:38PM +0000, Phillip Lougher wrote:
> Pavel Machek wrote:
> >
> >Al is right. Unconditional swap is probably faster than
> >branch. Avoiding swaps is nice, but avoiding branches is probably more
> >important.
> 
> Quite possible.
> 
> >
> >Can you try to benchmark it? I believe it is going to be lost in
> >noise, slow cpus or not.
> 
> Good idea, I'll try to benchmark it (on a slow CPU if I can find one :-) 
> ).  It will probably make no difference.
> 
> I don't want the lack of a fixed endianness on disk to become a problem. 
>   I personally don't think the use of, or lack of a fixed endianness to 
> be that important, but I'd prefer not to change the current situation 
> and adopt a fixed format.  I use big endian systems almost exclusively, 
> and I don't like the way fixed formats always tend to be little-endian.

You mean, like IP?  Or NFS?  Or XFS?  Or any number of other big-endian
data layouts?  Make it fixed to big-endian - no problem with that...
