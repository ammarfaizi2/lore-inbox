Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265872AbSKLBMN>; Mon, 11 Nov 2002 20:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265880AbSKLBML>; Mon, 11 Nov 2002 20:12:11 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:8909 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S265872AbSKLBMK>;
	Mon, 11 Nov 2002 20:12:10 -0500
Date: Tue, 12 Nov 2002 02:18:58 +0100
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au, lord@sgi.com
Subject: 2.5-bk AT_GID clash
Message-ID: <20021112011858.GB19877@gagarin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the new module-api making module.h including elf.h have exposed a name clash
in xfs:

include/linux/elf.h:175:#define AT_GID    13    /* real gid */
fs/xfs/linux/xfs_vnode.h:547:#define AT_GID             0x00000008

Can one be renamed? 

Maybe module.h shouldn't be including elf.h, that afaik is needed by the
arch-specific module loaders and not by all modules. A split into
module.h for the modules and moduleloader.h for the arch-spec-loaders?

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
