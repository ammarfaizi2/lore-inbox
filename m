Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283468AbRK3CU6>; Thu, 29 Nov 2001 21:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283469AbRK3CUs>; Thu, 29 Nov 2001 21:20:48 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:10996
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S283468AbRK3CUa>; Thu, 29 Nov 2001 21:20:30 -0500
Date: Thu, 29 Nov 2001 18:20:24 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: jose@iteso.mx
Cc: linux-kernel@vger.kernel.org
Subject: Re: 32 bit UIDs on 2.4.14
Message-ID: <20011129182024.A504@mikef-linux.matchmail.com>
Mail-Followup-To: jose@iteso.mx, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0111292002540.29568-100000@iteso.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0111292002540.29568-100000@iteso.mx>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 08:06:30PM -0600, jose@iteso.mx wrote:
> 
>  Hi.
> 
>   What is the trick to get more than 2^16 uids working on all services??
> 
>   I'm using kernel 2.4.14, libc6 compiled with 2.4.7 headers, lib(pam|nss)-ldap
>   openldap, wu-imap, cuci-pop, samba, telnet, ssh, Debian Potato.
> 
>   'id' and 'getent passwd high-uid-user' both return the right uid (which 
> is stored on the ldap system), but 'ls -l' truncates the uid if it's higher than
> 65536 (say for uid  80000, it reports  14464), and sshd, telnetd and imapd deny
> logins because setuid() invalidates a >16 bit interger as argument.
> 
>    What should I recompile??  is there a moderately easy workaround??
> 

That patch is in the 2.4.13-ac7 don't use -ac8.

It's probably somewhere else, but I don't know who origionally submited the
patch to Alan.

mf
