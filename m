Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbTKXXaq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 18:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTKXXaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 18:30:46 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:3463 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S261626AbTKXXap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 18:30:45 -0500
Date: Mon, 24 Nov 2003 18:28:30 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andy Lutomirski <luto@myrealbox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: hard links create local DoS vulnerability and security problems
In-Reply-To: <Pine.LNX.4.58.0311241313370.2893@home.osdl.org>
Message-ID: <Pine.GSO.4.33.0311241825300.13188-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Nov 2003, Linus Torvalds wrote:
>Just do
>
>	chmod ug-s file
>
>and you're done.
>
>If you delete the file first, you'll need roots help, but hey, be careful.

Heh, thus enters paranoia... patern fill the file (zero's will do), truncate,
'chmod 0', and *then* unlink it.  Yeah, it's eating up an inode charged to
the user, but otherwise, no space and the contents are gone.

--Ricky


