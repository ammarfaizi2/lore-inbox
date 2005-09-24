Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVIXTyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVIXTyh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 15:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVIXTyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 15:54:37 -0400
Received: from smtpout.mac.com ([17.250.248.86]:47325 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750723AbVIXTyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 15:54:37 -0400
In-Reply-To: <20050924070150.GL7992@ftp.linux.org.uk>
References: <E1EIonQ-0006Ts-00@dorka.pomaz.szeredi.hu> <20050923122834.659966c4.akpm@osdl.org> <E1EJ2xC-0007SZ-00@dorka.pomaz.szeredi.hu> <20050924060913.GK7992@ftp.linux.org.uk> <E1EJ3ib-0007V7-00@dorka.pomaz.szeredi.hu> <20050924070150.GL7992@ftp.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <305557E4-5EB5-48C6-BE00-04C5AA16924A@mac.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] open: O_DIRECTORY and O_CREAT together should fail
Date: Sat, 24 Sep 2005 15:53:53 -0400
To: Al Viro <viro@ftp.linux.org.uk>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 24, 2005, at 03:01:50, Al Viro wrote:
> And O_DIRECTORY is not the only flag that acquires or loses meaning  
> depending on O_CREAT - consider e.g. O_EXCL.  It's a mess, of  
> course, but this mess is part of userland ABI.  We tried to fix  
> symlink idiocy, BTW, on the assumption that nothing would be  
> relying on it.  Didn't work...

Maybe CONFIG_FIX_CRAPPY_ABI_CORNER_CASES?  If the user is willing to  
deal with some minimal breakage and fix programs relying on icky  
unsupported behavior, then they could turn that on for a slightly  
more secure system.  Make it depend on "experimental" and give it big  
warning messages.  It's likely that some of the more-secure server- 
oriented distros that run patched gcc and such to avoid buffer  
overflow and such might turn it on.

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



