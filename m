Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbTDUI52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 04:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbTDUI52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 04:57:28 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:7942 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S261287AbTDUI51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 04:57:27 -0400
Message-Id: <200304210900.h3L90vu07375@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: John Bradford <john@grabjohn.com>,
       skraw@ithnet.com (Stephan von Krawczynski)
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Date: Mon, 21 Apr 2003 12:09:07 +0300
X-Mailer: KMail [version 1.3.2]
Cc: john@grabjohn.com (John Bradford), linux-kernel@vger.kernel.org
References: <200304201421.h3KELqIU000303@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200304201421.h3KELqIU000303@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 April 2003 17:21, John Bradford wrote:
> > What is so bad about the simple way: the one who wants to write
> > (e.g. fs) and knows _where_ to write simply uses another newly
> > allocated block and dumps the old one on a blacklist. The blacklist
> > only for being able to count them (or get the sector-numbers) in
> > case you are interested. If you weren't you might as well mark them
> > allocated and that's it (which I would presume a _bad_ idea). If
> > there are no free blocks left, well, then the medium is full. And
> > that is just about the only cause for a write error then (if the
> > medium is writeable at all).
>
> Modern disks generally do this kind of thing themselves.  By the time
               ^^^^^^^^^^^^
How many times does Stephan need to say it? 'Generally do'
is not enough, because it means 'sometimes they dont'.

Most filesystems *are* designed with badblock lists and such,
it is possible to teach fs drivers to tolerate write errors
by adding affected blocks to the list and continuing (as opposed
to 'remounted ro, BOOM!'). As usual, this can only happen if someone
will step forward and code it.

Do you think it would be a Wrong Thing to do?
--
vda
