Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVKUSNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVKUSNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 13:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVKUSNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 13:13:10 -0500
Received: from port-195-158-168-246.dynamic.qsc.de ([195.158.168.246]:21377
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S932447AbVKUSNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 13:13:09 -0500
Message-ID: <43820E23.2060303@trash.net>
Date: Mon, 21 Nov 2005 19:12:51 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Folkert van Heusden <folkert@vanheusden.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.14] bug in inet_connection_sock.c -> lowest port always
 skipped
References: <20051121180224.GY32512@vanheusden.com>
In-Reply-To: <20051121180224.GY32512@vanheusden.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden wrote:
> There seems to be a small bug in inet_connection_sock.c: the lowest port
> set using sysctl (taken from 'sysctl_local_port_range') is always
> skipped in the first iteration.
> In inet_csk_get_port one can find this:
>                 if (hashinfo->port_rover < low)
>                         rover = low;
>                 else
>                         rover = hashinfo->port_rover;
>                 do {
>                         rover++;
> As you can see the first statement is a ++ causing the first port to
> always be skipped.

This has already been fixed three weeks ago by Stephen Hemminger's port
randomization patch.
