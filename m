Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264900AbUGVOXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbUGVOXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 10:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265966AbUGVOXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 10:23:33 -0400
Received: from [195.23.16.24] ([195.23.16.24]:50086 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S264900AbUGVOXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 10:23:32 -0400
Subject: Re: Inode question
From: Paulo Marques <pmarques@grupopie.com>
Reply-To: pmarques@grupopie.com
To: sankarshana rao <san_wipro@yahoo.com>
Cc: root@chaos.analogic.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040721225752.90581.qmail@web50902.mail.yahoo.com>
References: <20040721225752.90581.qmail@web50902.mail.yahoo.com>
Content-Type: text/plain
Organization: Grupo PIE
Message-Id: <1090506209.8842.20.camel@pmarqueslinux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 22 Jul 2004 15:23:30 +0100
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.26.0.10; VDF: 6.26.0.39; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-21 at 23:57, sankarshana rao wrote:
> Guys,
> Thx for the inputs...I got it with path_lookup....
> 
> Can I pass the inode pointer back to the user space???

To get an inode number from user space you can simply use the "stat" or
"fstat" functions. You don't need to create your own module.

> I have a scenario in which I have to create multiple
> folders on the harddisk. The number of folders can be
> in hundreds. Instead of parsing the path name
> everytime I need to create a folder (that's what
> sys_mkdir does??? ), I was thinking if I have the
> inode* of the parent folder, I can avoid this parsing
> and directly create a subfolder under the parent
> folder...

Is this really a problem? The dentry cache should make this quite fast,
leaving the bottleneck to the actual write on disk of the result.

I tried a small program (if it can be called a program) to create a
thousand directories and it takes less than 100 ms on my machine.

Best regards,

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

