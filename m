Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVF1Uqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVF1Uqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVF1Uqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:46:44 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:46077 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261606AbVF1UpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:45:13 -0400
Message-ID: <3886.10.10.10.24.1119991512.squirrel@linux1>
In-Reply-To: <62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
    <20050624064101.GB14292@pasky.ji.cz>
    <20050624123819.GD9519@64m.dyndns.org>
    <20050628150027.GB1275@pasky.ji.cz> <20050628180157.GI12006@waste.org>
    <62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com>
Date: Tue, 28 Jun 2005 16:45:12 -0400 (EDT)
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
From: "Sean" <seanlkml@sympatico.ca>
To: "Kyle Moffett" <mrmacman_g4@mac.com>
Cc: "Matt Mackall" <mpm@selenic.com>, "Petr Baudis" <pasky@ucw.cz>,
       "Christopher Li" <hg@chrisli.org>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Git Mailing List" <git@vger.kernel.org>, mercurial@selenic.com
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, June 28, 2005 4:27 pm, Kyle Moffett said:
> On Jun 28, 2005, at 14:01:57, Matt Mackall wrote:
>> Everything in Mercurial is an append-only log. A transaction journal
>> records the original length of each log so that it can be restored on
>> failure.
>
> Does this mean that (excepting the "undo" feature) one could set the
> ext3 "append-only" attribute on the repository files to avoid losing
> data due to user account compromise?
>

Probably.  In Git, which is a bit more flexible than Mecurial you can
chmod your objects to read-only or use the ext3 immutable setting to
protect your existing objects.   You can even have a setup where objects
are archived onto write-once media like DVD and still participate in a
live repository, where new objects are written to hard disk, but older
object are (automatically) sourced from the DVD.

Sean


