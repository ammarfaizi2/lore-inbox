Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTHUPOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTHUPOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:14:35 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4992 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262683AbTHUPOd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:14:33 -0400
Date: Thu, 21 Aug 2003 11:14:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Pankaj Garg <PGarg@MEGISTO.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Messaging between kernel modules and User Apps
In-Reply-To: <AD3C7008DB448D42ABA9346FE715E8340FFEF8@megisto-e2k.megisto.com>
Message-ID: <Pine.LNX.4.53.0308211109320.2718@chaos>
References: <AD3C7008DB448D42ABA9346FE715E8340FFEF8@megisto-e2k.megisto.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003, Pankaj Garg wrote:

> Hi,
>
> I am writing a kernel module. The module will need to send asynchronous
> messages to a User Application. Is there a good and efficient way of
> doing this?
>
>
> Thanks,
> Pankaj
>
The de facto standard for network devices is to use sockets.
For character and and block devices Unix/Linux uses the
open/poll/ioctl/read mechanisms.
Some Linux drivers use the /proc file-system for 'information'.
You could send your module a pid via proc and have it send a
signal to your application as a result of an event.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


