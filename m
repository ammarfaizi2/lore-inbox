Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbUKKPM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbUKKPM1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 10:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbUKKPJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 10:09:52 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:32211 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262246AbUKKPHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 10:07:00 -0500
Subject: Re: 2.4.26 IDE driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Siddhesh Bhadkamkar <siddheish@hotmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BAY2-F311s7nlT2NqFJ0002718f@hotmail.com>
References: <BAY2-F311s7nlT2NqFJ0002718f@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100181833.22256.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 11 Nov 2004 14:03:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-11-11 at 14:56, Siddhesh Bhadkamkar wrote:
> this driver will expose only a part of the disk to file system by reporting 
> the disk capacity as say real_capacity/4. remaining disk will be hidden from 
> the file system. in write operation driver will try to write the same data 
> in all 4 parts of the same disk for redundancy. in read it will hope to find 
> atleast one copy properly written.
> 
> we are using kernel version 2.4.26. what approach do you think would be 
> appropriate?

The md driver will do most of this for you, but in truth drives are not
laid out physically and generally go wrong all at once or rapidly
develop errors all over the disk.

As a learning exercise then I'd probably start with the md driver

