Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290626AbSAYNYP>; Fri, 25 Jan 2002 08:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290669AbSAYNYG>; Fri, 25 Jan 2002 08:24:06 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:21515 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S290626AbSAYNYB>; Fri, 25 Jan 2002 08:24:01 -0500
Message-ID: <3C515D7F.3145102E@loewe-komp.de>
Date: Fri, 25 Jan 2002 14:28:31 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: frank.van.maarseveen@altium.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: restoring hard linked files from zisofs/iso9660 w. RR
In-Reply-To: <20020125135545.A28897@espoo.tasking.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen schrieb:
> 
> This doesn't seem to work due to inode number differences. Is
> this a fundamental problem or can it be solved somehow, e.g.
> by an attribute which refers to a sort of "original" inode
> number?
> 
> or by a more advanced inode number synthesis in fs/isofs?
> 

Don't know about isofs, but hardlinks do not use an inode.
It's just another entry in a directory pointing to a "used"
inode (there is another entry refering to the same inode)

fast symlinks do occupy an inode, symlinks an inode + 1 diskblock.
