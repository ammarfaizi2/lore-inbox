Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTKXVQe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 16:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTKXVQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 16:16:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:45781 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261226AbTKXVQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 16:16:33 -0500
Date: Mon, 24 Nov 2003 13:16:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems
In-Reply-To: <3FC27019.7010402@myrealbox.com>
Message-ID: <Pine.LNX.4.58.0311241313370.2893@home.osdl.org>
References: <fa.hevpbbs.u5q2r6@ifi.uio.no> <fa.l1quqni.v405hu@ifi.uio.no>
 <3FC27019.7010402@myrealbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Nov 2003, Andy Lutomirski wrote:
>
> Right... but non-privileged users _can't_ delete these extra links, even
> if they notice them from the link count.  And non-idiots do make
> security errors -- they just fix them.  But in this case, fixing the
> error after the fact may be impossible without root's help.

Just do

	chmod ug-s file

and you're done.

If you delete the file first, you'll need roots help, but hey, be careful.

		Linus
