Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbUDRSBt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 14:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUDRSBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 14:01:24 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:28944 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S263645AbUDRSBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 14:01:15 -0400
Date: Sun, 18 Apr 2004 19:58:56 +0200
From: DervishD <raul@pleyades.net>
To: Remi Colinet <remi.colinet@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Questions : disk partition re-reading
Message-ID: <20040418175856.GC3612@DervishD>
Mail-Followup-To: Remi Colinet <remi.colinet@free.fr>,
	linux-kernel@vger.kernel.org
References: <4082819E.10106@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4082819E.10106@free.fr>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Remi :)

 * Remi Colinet <remi.colinet@free.fr> dixit:
> 1/ Is it possible to alter a disk partition of a used disk and beeing 
> able to use the modified partition without having to reboot the box?

    sfdisk -R <disk-you-want-to-get-its-partition-table-reread>
 
> 2/ Is it possible to delete a disk partition without having the 
> partition numbers changed?

    For primary partitions, it is possible. Don't know for extended
ones :??
 
> Do I need to upgrade fdisk or use an other utility?

    AFAIK, fdisk will do, except for rereading. Well, 'fdisk'
actually *do* a rereading, but only after altering the partition
table of the disk. 'sfdisk' can do it on demand, but if the disk is
busy the BKLRRPART ioctl will fail.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
