Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbTEFGbZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 02:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTEFGbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 02:31:25 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:29656 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S262390AbTEFGbU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 02:31:20 -0400
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Organization: Ozzmosis Corp.
To: sumit_uconn@lycos.com
Subject: Re: inode number
Date: Tue, 6 May 2003 03:43:50 -0300
User-Agent: KMail/1.5
References: <MHCBNPOFCDJPBDAA@mailcity.com>
In-Reply-To: <MHCBNPOFCDJPBDAA@mailcity.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305060343.50191.lucasvr@gobolinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You can give a look on user_path_walk() and user_path_walk_link() (see 
include/linux/fs.h), given you have the pathname. 
Given you have the inode number, you can get one of the references to it by 
using d_path() (see include/linux/sched.h). I just don't know how it works  
when there is multiple references to the same inode number (hard links).

Lucas


On Tuesday 06 May 2003 00:52, Sumit Narayan wrote:
> Hi,
>
> Actually, what I meant with this was, suppose I have a file name, how do I
> get the inode for that? And also suppose I have the inode number, how do I
> get the complete object of that inode for use and manipulation?
>
> Thanks in advance
>
> Sumit
> --
>
> On Mon, 05 May 2003 23:27:32
>
>  Sumit Narayan wrote:
> >Hi,
> >
> >How do I know which file has what Inode number? and its under which super
> > block?
> >
> >Thanks
> >
> >Sumit
> >
> >
> >____________________________________________________________
> >Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
> >http://login.mail.lycos.com/r/referral?aid=27005
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
>
> ____________________________________________________________
> Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
> http://login.mail.lycos.com/r/referral?aid=27005
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

