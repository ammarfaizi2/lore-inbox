Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbVKNEel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbVKNEel (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 23:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbVKNEel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 23:34:41 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:18184 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1750904AbVKNEek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 23:34:40 -0500
Date: Mon, 14 Nov 2005 12:35:09 -0500 (EST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: plug@plug.org.au
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [plug] smb client timeout problem - FIXED
In-Reply-To: <200511132309.43738.sboak@westnet.com.au>
Message-ID: <Pine.LNX.4.58.0511141227170.13074@wombat.indigo.net.au>
References: <200511120941.57985.sboak@westnet.com.au> <200511132309.43738.sboak@westnet.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-5.899,
	required 5, autolearn=not spam, ALL_TRUSTED -3.30, BAYES_00 -2.60)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Nov 2005, Steve Boak wrote:

> Update...
> 
> Just in case someone else comes up with this problem, I found the answer by 
> combining all the information (more hints actually) that I gleaned from 
> google, and then taking a stab in the dark :-)
> 
> The simple fix is to use the cifs filesystem instead of smbfs when mounting 
> remote samba shares on a Linux box. Apparently cifs has superceded smbfs and 
> works much better in this case, but I still need to use smbfs when mounting 
> shares from my windows box. Information is rather hard to find on the subject 
> of samba/smbfs/cifs.

smbfs is currently unmaintained and likely to move to depricated status 
some time soon, so bug fixes are probably not being done.

I believe CIFS will be recommened for everything and should work for 
everything in the near future or already does.

> 
> I had to recompile the kernel to get cifs support.
> 
> Not sure of the finer details yet, but at least now I have a working system 
> again. Here's the combinations I have found that works:
> 
> (Note that all my tests were done with at least kernel 2.6.13, Samba 3.0.20b, 
> and Debian Testing on both machines)
> 
> Linux client	mount -t cifs ...	shares from Samba server
> Linux client	mount -t smbfs ...	shares from Windows-2000
> Windows client	uses smbfs?	shares from Samba server

Interesting to see that this is still a problem in 2.6.13.
Have you tried 2.6.14?

Anyone know the status of CIFS?

Ian

