Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267351AbUHDRIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267351AbUHDRIG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 13:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267356AbUHDRIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 13:08:06 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:64672 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267351AbUHDRID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 13:08:03 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Wed, 4 Aug 2004 10:06:18 -0700
User-Agent: KMail/1.6.2
Cc: Jon Smirl <jonsmirl@yahoo.com>, linux-kernel@vger.kernel.org
References: <E12D1EA555A@vcnet.vc.cvut.cz>
In-Reply-To: <E12D1EA555A@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408041006.18877.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 4, 2004 8:57 am, Petr Vandrovec wrote:
> Test for failure? Test for no ROM devices?

If we get here, we can be sure there's a ROM device otherwise the 'rom' file 
wouldn't have been created.

> Please read it with readl. At least on my Matrox G550 reading 64KB ROM with
> byte accesses takes 1334ms, with 16bit accesses 840ms and with
> 32bit (or 64bit MMX) accesses 551ms. Straight (non-IO aware) memcpy
> takes 535ms. And put some conditional_schedule()s here, 550ms (or even
> 34ms for 4KB chunk) is IMHO too long.

memcpy_from_io maybe?  That would probably make the most sense.

Thanks for the comments.  Jon, do you want to respin it?

Thanks,
Jesse
