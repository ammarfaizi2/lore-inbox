Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTKMQpu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 11:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTKMQpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 11:45:50 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:51124 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264358AbTKMQps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 11:45:48 -0500
Date: Thu, 13 Nov 2003 17:45:44 +0100
From: bert hubert <ahu@ds9a.nl>
To: Remco van Mook <remco@virtu.nl>
Cc: linux-kernel@vger.kernel.org
Subject: buffer/page cache aliasing? Re: 2.4 odd behaviour of ramdisk + cramfs
Message-ID: <20031113164544.GA24997@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Remco van Mook <remco@virtu.nl>, linux-kernel@vger.kernel.org
References: <5.1.0.14.2.20031113171537.01ee82c8@services3.virtu.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20031113171537.01ee82c8@services3.virtu.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 05:32:49PM +0100, Remco van Mook wrote:

> #! /bin/sh
> cat /flash/modules-2.4.21 > /dev/ram1
> mount -t cramfs -o ro /dev/ram1 /lib/modules
> 
> Running it once causes the mount to fail with 'cramfs: wrong magic' - 
> running it twice will make mount succeed on the second try.

Sounds like buffer/page cache aliasing perhaps? Does it work with other
filesystems? 

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
