Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWAaDx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWAaDx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 22:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWAaDx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 22:53:56 -0500
Received: from terminus.zytor.com ([192.83.249.54]:53456 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030207AbWAaDxz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 22:53:55 -0500
Message-ID: <43DEDF46.2060505@zytor.com>
Date: Mon, 30 Jan 2006 19:53:42 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Neil Brown <neilb@cse.unsw.edu.au>, linux-raid@vger.kernel.org,
       klibc list <klibc@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [klibc] Exporting which partitions to md-configure
References: <43DEB4B8.5040607@zytor.com> <20060131032133.GA8920@kroah.com>
In-Reply-To: <20060131032133.GA8920@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> What are you looking for exactly?  udev has a great helper program,
> volume_id, that identifies any type of filesystem that Linux knows about
> (it was based on the ext2 lib code, but smaller, and much more sane, and
> works better.)
> 
> Would that help out here?
> 

It might, but it's also rather ugly to have two pieces of code, 
especially in the presence of very dynamic partitions.  In other words, 
if the kernel deals with partitions, you want to be able to get at the 
kernel's view of partitions, not necessarily the actual set of 
partitions on disk, which can be quite different.

	-hpa
