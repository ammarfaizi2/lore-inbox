Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263619AbTDTPza (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 11:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTDTPza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 11:55:30 -0400
Received: from mail.ithnet.com ([217.64.64.8]:60942 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263619AbTDTPz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 11:55:29 -0400
Date: Sun, 20 Apr 2003 18:07:20 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jos Hulzink <josh@stack.nl>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-Id: <20030420180720.099b4c34.skraw@ithnet.com>
In-Reply-To: <200304192313.53955.josh@stack.nl>
References: <20030419180421.0f59e75b.skraw@ithnet.com>
	<1050766175.3694.4.camel@dhcp22.swansea.linux.org.uk>
	<200304192313.53955.josh@stack.nl>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Apr 2003 23:13:53 +0200
Jos Hulzink <josh@stack.nl> wrote:

> [...]
> Fault tolerance in a filesystem layer means in practical terms that you are 
> guessing what a filesystem should look like, for the disk doesn't answer that
> 
> question anymore. IMHO you don't want that to be done automagically, for it 
> might go right sometimes, but also might trash everything on RW filesystems.

Let me clarify again: I don't want fancy stuff inside the filesystem that
magically knows something about right-or-wrong. The only _very small_
enhancement I would like to see is: driver tells fs there is an error while
writing a certain block => fs tries writing the same data onto another block.
That's it, no magic, no RAID stuff. Very simple.

> Fault tolerance OK, but the fs layer should only detect errors reported by
> the lower level drivers and handle them gracefully (which is something that
> might need impovement a little for some fs drivers), or else trust the data
> it gets. 

You are completely right, I don't want any more: nice management of an error a
low-level driver reports to the fs. Only I would like to see as an fs-answer to
this: ok, let's try another part of the media. Currently it just sinks like
titanic.

Regards,
Stephan
