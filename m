Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273414AbRINPQo>; Fri, 14 Sep 2001 11:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273416AbRINPQd>; Fri, 14 Sep 2001 11:16:33 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:10761 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S273414AbRINPQ1>; Fri, 14 Sep 2001 11:16:27 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Jan Kara <jack@ucw.cz>
cc: Paul Menage <pmenage@ensim.com>, alan@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.2.20: Avoid buffer overrun in quota warning 
In-Reply-To: Your message of "Fri, 14 Sep 2001 10:46:57 +0200."
             <20010914104657.E31478@atrey.karlin.mff.cuni.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 14 Sep 2001 08:15:12 -0700
Message-Id: <E15hugS-0006C4-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Actually that delayed printing of quota messages isn't even in regular
>2.4 - it's just in ac-patches. Regular 2.4 has just print_warning()
>function which works rather the same way as printing in 2.2.

Regular 2.4 prints bdevname(dquot->dq_sb->s_dev) rather than 
dquot->dq_mnt->mnt_dirname, so is rather less likely to have the same
sprintf() overrun problems.

Paul

