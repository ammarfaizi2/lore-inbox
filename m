Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265986AbUFDUa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265986AbUFDUa6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUFDUa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:30:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:64389 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265986AbUFDU3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:29:53 -0400
Date: Fri, 4 Jun 2004 13:26:53 -0700
From: Greg KH <greg@kroah.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-bk4: empty-named directory in /sys
Message-ID: <20040604202653.GA13311@kroah.com>
References: <200406042253.23428.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406042253.23428.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 10:53:23PM +0300, Denis Vlasenko wrote:
> # ls /sys
>    block  bus  class  devices  firmware  module
> # ls -l /sys
> total 0
> drwxr-xr-x   9 root     root            0 Jun  5  2004
> drwxr-xr-x  29 root     root            0 Jun  5  2004 block
> drwxr-xr-x  10 root     root            0 Jun  5  2004 bus
> drwxr-xr-x  16 root     root            0 Jun  5  2004 class
> drwxr-xr-x   7 root     root            0 Jun  5  2004 devices
> drwxr-xr-x   2 root     root            0 Jun  5  2004 firmware
> drwxr-xr-x  30 root     root            0 Jun  5  2004 module
> 
> I cannot enter that directory. Actually, it looks more like
> directory named " ", because I get similar ls outputs when
> I create regular directory named " ". However, I can enter into
> regular directory named " ", unlike /sys one.
> 
> # mkdir " " a b c
> # ls
>    a  b  c
> # ls -l
> total 0
> drwxr-xr-x   2 root     root           48 Jun  4 22:45
> drwxr-xr-x   2 root     root           48 Jun  4 22:45 a
> drwxr-xr-x   2 root     root           48 Jun  4 22:45 b
> drwxr-xr-x   2 root     root           48 Jun  4 22:45 c
> 
> .config and boot messages are attached

Hm, is the hostap code in the main kernel tree now?  That's the only
thing odd that I see from your messages.  Does this happen with
2.6.7-rc2 with no extra patches?

thanks,

greg k-h
