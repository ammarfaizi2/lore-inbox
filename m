Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWAaBq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWAaBq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 20:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWAaBq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 20:46:59 -0500
Received: from terminus.zytor.com ([192.83.249.54]:8428 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932177AbWAaBq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 20:46:58 -0500
Message-ID: <43DEC157.1000002@zytor.com>
Date: Mon, 30 Jan 2006 17:45:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Neil Brown <neilb@suse.de>, klibc list <klibc@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: Exporting which partitions to md-configure
References: <43DEB4B8.5040607@zytor.com> <17374.47368.715991.422607@cse.unsw.edu.au> <859CB9D0-A1D3-4931-9D9F-96153D0F3E1B@mac.com>
In-Reply-To: <859CB9D0-A1D3-4931-9D9F-96153D0F3E1B@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> 
> Well, for an MSDOS partition table, you would look for '253', for a  Mac 
> partition table you could look for something like 'Linux_RAID' or  
> similar (just arbitrarily define some name beginning with the Linux_  
> prefix), etc.  This means that the partition table type would need to  
> be exposed as well (I don't know if it is already).
> 

It's not, but perhaps exporting "format" and "type" as distinct 
attributes is the way to go.  The policy for which partitions to 
consider would live entirely in kinit that way.

type would be format-specific; in EFI it's a UUID.

This, of course, is a bigger change, but it just might be worth it.

	-hpa
