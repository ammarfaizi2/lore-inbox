Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbUKITJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUKITJm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUKITJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:09:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:50148 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261627AbUKITJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:09:17 -0500
Date: Tue, 9 Nov 2004 11:09:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Christian Kujau <evil@g-house.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@gmail.com>, Matt_Domsch@dell.com
Subject: Re: [PATCH] kobject: fix double kobject_put() in error path of
 kobject_add()
In-Reply-To: <20041109190420.GA2498@kroah.com>
Message-ID: <Pine.LNX.4.58.0411091108470.2301@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org>
 <418F6E33.8080808@g-house.de> <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org>
 <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de>
 <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com>
 <4190B910.7000407@g-house.de> <20041109164238.M12639@g-house.de>
 <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org> <20041109190420.GA2498@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Nov 2004, Greg KH wrote:
>
> This fixes a problem introduced in the previous set of driver model
> changes that has been seen by a lot of people (most notibly the greater
> than 256 pty users, but others might also be hitting this without
> realizing it.)

Ahh.. Christian, pls test this one.

		Linus
