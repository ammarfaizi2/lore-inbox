Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262230AbRETU1T>; Sun, 20 May 2001 16:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262236AbRETU1K>; Sun, 20 May 2001 16:27:10 -0400
Received: from ns.suse.de ([213.95.15.193]:24327 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262235AbRETU1A>;
	Sun, 20 May 2001 16:27:00 -0400
Date: Sun, 20 May 2001 22:26:10 +0200
From: Andi Kleen <ak@suse.de>
To: David Osojnik <dworf@siol.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tcp_mem problem
Message-ID: <20010520222610.A25477@gruyere.muc.suse.de>
In-Reply-To: <01052019331500.00946@cool>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01052019331500.00946@cool>; from dworf@siol.net on Sun, May 20, 2001 at 07:33:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 07:33:15PM +0200, David Osojnik wrote:
> the system with problem is using kernel 2.4.2 on an P200 with 64mb ram. It 
> has about 20 users that use the box... (ftp, telnet, lynx, bitchx,...).
> 
> the problem is when the parameter tcp_mem HIGH gets exeded after about a day 
> of use! Then the box is going from the net and its not awailable. I tried to 
> tune the system with adding more in proc tcp_mem but the problem is still 
> there the box only lasts for bout 2h longer.
> 
> and i get this in messages
> 
> kernel: TCP: too many of orphaned sockets
> 
> It looks like my system is not droping closed sockets?

You can check by using netstat -tan 
Normally the message is harmless; when it happens the closed sockets are
RST instead of being closed properly.


-Andi
