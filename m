Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271791AbRIMPg0>; Thu, 13 Sep 2001 11:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271797AbRIMPgP>; Thu, 13 Sep 2001 11:36:15 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:56285 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S271791AbRIMPfz>; Thu, 13 Sep 2001 11:35:55 -0400
From: Stefan Hoffmeister <lkml.2001@econos.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 and eepro100
Date: Thu, 13 Sep 2001 17:35:54 +0200
Organization: Econos
Message-ID: <hek1qtoaeq1a9t8lq8fqlha6frvf1ufho1@4ax.com>
In-Reply-To: <3BA0C88D.6B170BD5@mediascape.de>
In-Reply-To: <3BA0C88D.6B170BD5@mediascape.de>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: On Thu, 13 Sep 2001 16:54:05 +0200, Olaf Zaplinski wrote:

>I got the 2.2.19 sorces, patched them with reiserfs, compiled and booted the
>new kernel. Neither the builtin eepro100 nor Intels e100-1.6.13 driver
>worked; they were loaded, but ifconfig failed:
>
>+ ifconfig eth1 192.168.0.235 broadcast 192.168.0.255 netmask 255.255.255.0
>up
>SIOCSIFFLAGS: Resource temporarily unavailable
>SIOCSIFFLAGS: Resource temporarily unavailable

Try to cold boot. I have experienced difficulties with 2.4.x and 2.2.x
interacting on a cold reboot.

It would seem that the 2.2.19 kernel does not get a valid MAC address when
*warm* booted into from a 2.4.x kernel.

[This used to be a problem with 2.4.x <-> 2.4.x, but 2.4.7 fixed that.]
