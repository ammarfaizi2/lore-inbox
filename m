Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUFYS5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUFYS5Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266832AbUFYS5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:57:25 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:36268 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262208AbUFYS4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:56:12 -0400
Message-ID: <40DC7539.7000803@comcast.net>
Date: Fri, 25 Jun 2004 14:55:53 -0400
From: David van Hoose <david.vanhoose@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
CC: "Philip R. Auld" <pauld@egenera.com>,
       Christoph Hellwig <hch@infradead.org>,
       Helge Hafting <helge.hafting@hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
References: <Pine.LNX.4.44.0406251438420.15676-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0406251438420.15676-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you.
It says ext2. Based on other messages, I look at /sbin/mkinitrd.
It looks to me that RedHat/Fedora are pretty dumb making stupid 
assumptions about the fs type instead of looking at the filesystem types 
that root has setup in fstab.
I've patched my mkinitrd script to check the fs type of the root 
partition according to /proc/mounts. This should work unless someone is 
overriding mkinitrd to build an initrd for a foreign system or changing 
their root partition. To fix that, I've added an command-line option to 
specify the fs type of the root partition.

Thanks very very much.
Sorry for the error. I assumed too much about RedHat.

Thanks,
David

Tigran Aivazian wrote:
> # gzip -dc /boot/initrd-2.4.21-15.EL.img | file -
> standard input:              Linux rev 1.0 ext2 filesystem data
> 
> Make sure you use the correct filename for your initrd image (check 
> /etc/grub.conf to find out which one is used).
> 
> Kind regards
> Tigran
> 
