Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbVLaGzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVLaGzF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 01:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVLaGzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 01:55:05 -0500
Received: from web34110.mail.mud.yahoo.com ([66.163.178.108]:10126 "HELO
	web34110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751032AbVLaGzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 01:55:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=aqX2VKh3e87YKv6Mulw+85XvgmKtoRkBeOnjMpFAuN28nAC1/MQpaLeLhcOuXoA8+R+0etQgeA6wT88rUfOcgldqFDKDbFzv+eo5EBETyimt2lYt0jKArR7mhPn5f8hc4NfB2B4TeRx9EZfpVMb9hxpFNzPi28Uz7qjb4+e9SFI=  ;
Message-ID: <20051231065503.68614.qmail@web34110.mail.mud.yahoo.com>
Date: Fri, 30 Dec 2005 22:55:03 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: RAID controller safety
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1135990179.28365.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I finally tracked through the i2o code, and found that i2o_block_device_flush is ultimately
called for fsync.  Sorry for being so dense.

However, it does look like barriers are not directly supported.  So, are they safe to use in ext3,
or is ext3 all fine without them?  Would barriers benefit i2o devices, or is there some reason to
not have them?

As for the controller defaulting to write-back, I still cannot find anything that would set the
cache mode to write-through in the non-battery-backed case.

-Kenny



	
		
__________________________________ 
Yahoo! for Good - Make a difference this year. 
http://brand.yahoo.com/cybergivingweek2005/
