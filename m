Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbULDCMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbULDCMR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 21:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbULDCMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 21:12:16 -0500
Received: from 209-128-68-124.bayarea.net ([209.128.68.124]:8660 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262521AbULDCMK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 21:12:10 -0500
Message-ID: <41B11CEB.30103@zytor.com>
Date: Fri, 03 Dec 2004 18:11:55 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
CC: klibc@zytor.com, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org
Subject: Re: INITRAMFS: allow no trailer
References: <200412040147.iB41lIlK031974@sullivan.realtime.net>
In-Reply-To: <200412040147.iB41lIlK031974@sullivan.realtime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milton Miller wrote:
> 
> hpa points out that you should be careful with the headers, use unique
> inode numbers and/or add a cpio header with just TRAILER!!! to reset
> the inode hash table to avoid unwanted hard links.  I just put this
> sequence as the last files loaded.
> 

Correction.  I just remembered we wrote the spec so that a file with a 
link count of 1 is not entered in the hash table and therefore is never 
hardlinked.  This should do what you need.  (This was obviously done for 
exactly this reason.)

	-hpa
