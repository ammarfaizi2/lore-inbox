Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUJEWQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUJEWQu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUJEWQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:16:50 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:43019 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266127AbUJEWQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:16:43 -0400
Message-ID: <35fb2e59041005151661d7a0b4@mail.gmail.com>
Date: Tue, 5 Oct 2004 23:16:34 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "valdis.kletnieks@vt.edu" <valdis.kletnieks@vt.edu>
Subject: Re: block till hotplug is done?
Cc: Harald Dunkel <harald.dunkel@t-online.de>,
       Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200410052038.i95Kc8VM004041@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1097005927.4953.4.camel@simulacron> <4163005B.2090000@t-online.de>
	 <200410052038.i95Kc8VM004041@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Oct 2004 16:38:08 -0400, valdis.kletnieks@vt.edu
<valdis.kletnieks@vt.edu> wrote:
> On Tue, 05 Oct 2004 22:13:15 +0200, Harald Dunkel said:
> > Andreas Jellinghaus wrote:
> > > Hi,
> > >
> > > is there any way to block till all hotplug events are handled/
> > > the hotplug processes terminated?
> > >
> >
> > while [ "`ps | grep /sbin/hotplug | grep -v grep`" ]; do sleep 1; done
> 
> Save a process:
> 
> while [ "`ps | grep '/sbin/[h]otplug'`" ]; do sleep 1; done

Why not sit a script in /etc/dev.d and have that wake up your fsck
script by signalling a flag file somewhere or somesuch - I think this
is the preferable to do stuff with udev, Greg?

Jon.
