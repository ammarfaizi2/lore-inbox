Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266309AbUBLIzD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 03:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266314AbUBLIzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 03:55:02 -0500
Received: from mail.shareable.org ([81.29.64.88]:50049 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266309AbUBLIzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 03:55:00 -0500
Date: Thu, 12 Feb 2004 08:54:51 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040212085451.GC20898@mail.shareable.org>
References: <20040209115852.GB877@schottelius.org> <slrn-0.9.7.4-32556-23428-200402111736-tc@hexane.ssi.swin.edu.au> <1076517309.21961.169.camel@shaggy.austin.ibm.com> <20040212004532.GB29952@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212004532.GB29952@hexapodia.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:
> Why on earth is JFS worried about the filename, anyways?  Why has it
> *ever* had *any* behavior other than "string of bytes, delimited with /,
> terminated with \0" ?

Perhaps for the same reason that these other in-tree filesystems are
sensitive to the character encoding:

   Joliet (ISO-9660 extension), FAT/VFAT, NTFS, BeFS, SMBFS, CIFS.

Those filesystems will also fail, or give unexpected behaviour (such
as bytes being changed to '?'), if you pass them names which are not
in the appropriate encoding.

-- Jamie
