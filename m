Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269981AbUJWB6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269981AbUJWB6p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269936AbUJWBvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:51:00 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:43024 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S269845AbUJWBsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 21:48:47 -0400
Message-ID: <4179B87D.3020505@superbug.co.uk>
Date: Sat, 23 Oct 2004 02:48:45 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arvind Kalyan <base16@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: GPRS on Linux fails due to 255.255.255.255 remote address.
References: <90c25f2704102211212031af71@mail.gmail.com>
In-Reply-To: <90c25f2704102211212031af71@mail.gmail.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arvind Kalyan wrote:
> Hi,
> 
> I'm trying to use my Airtel GPRS connection under Linux.
> 
> 
> Status: pppd refuses connection due to improper remote IP address
> (255.255.255.255)
> 

This is a bug in pppd or the linux kernel.
Can the linux kernel handle un-numbered Point-to-Point links?

This is a point-to-point link, so we should ignore the remote IP 
address, and add local routes (e.g. default route) pointing to interface 
names, and not IP addresses.

I agree that it would have looked prettier if the remote end used 
something other than 255.255.255.255, but pppd should not care about it, 
so who cares what number it is.

I do not know if this is a bug in the linux kernel, or just pppd.
Can the linux kernel handle un-numbered Point-to-Point links?

James
