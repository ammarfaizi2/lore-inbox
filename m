Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422778AbWGJXEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422778AbWGJXEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422925AbWGJXEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:04:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:27523 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422778AbWGJXEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:04:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AJyRIdwWYH62eQT0e+I8yJp/wDnNniwcYn7+3EkJLGNfEDcpuUM/MDS6VWA7Me8SnNKhZekOsCVD3y12ZHaexMWy0Nblzbo9UuwiRA9gNmrH+O6mxKSeS2+sEI8MK5aYJHse4RwFHkpwYP75zYVL5yDhIBPjFIcrKbmcm1+pRIk=
Message-ID: <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com>
Date: Mon, 10 Jul 2006 19:04:08 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty's use of file_list_lock and file_move
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1152573312.27368.212.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152552806.27368.187.camel@localhost.localdomain>
	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
	 <1152554708.27368.202.camel@localhost.localdomain>
	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
	 <1152573312.27368.212.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Llu, 2006-07-10 am 18:35 -0400, ysgrifennodd Jon Smirl:
> > Assuming do_SAK has blocked anyone's ability to newly open the tty,
> > why does it need to search every file handle in the system instead of
> > just using tty->tty_files? tty->tty_files should contain a list of
> > everyone who has the tty open. Is this global search needed because of
> > duplicated handles?
>
> I don't actually know. Thats an area I've not dug too deeply into at
> all.

I wonder what the impact of banging on the SAK key on a box with 100K
processes is like. You may be able to stall the whole system.

-- 
Jon Smirl
jonsmirl@gmail.com
