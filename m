Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277093AbRJKX7H>; Thu, 11 Oct 2001 19:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277100AbRJKX66>; Thu, 11 Oct 2001 19:58:58 -0400
Received: from taifun.devconsult.de ([212.15.193.29]:52748 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S277093AbRJKX6m>; Thu, 11 Oct 2001 19:58:42 -0400
Date: Fri, 12 Oct 2001 01:59:08 +0200
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Dan Hollis <goemon@anime.net>
Cc: Marcus Meissner <mm@ns.caldera.de>, war <war@starband.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Can only login via ssh 1013 times.
Message-ID: <20011012015907.A26975@devcon.net>
Mail-Followup-To: Dan Hollis <goemon@anime.net>,
	Marcus Meissner <mm@ns.caldera.de>, war <war@starband.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200110112136.f9BLakI04545@ns.caldera.de> <Pine.LNX.4.30.0110111445140.2188-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0110111445140.2188-100000@anime.net>; from goemon@anime.net on Thu, Oct 11, 2001 at 02:46:51PM -0700
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 11, 2001 at 02:46:51PM -0700, Dan Hollis wrote:
> 
> Maybe kernel could printk a warning when file-max (or other) limit is
> reached...?

It is already done:

,----[ fs/file_table.c ]-
| [...]
| } else if (files_stat.max_files > old_max) {
|         printk(KERN_INFO "VFS: file-max limit %d reached\n", files_stat.max_files);
|         old_max = files_stat.max_files;
| }
| [...]
`----

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
