Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264017AbTJ1Ptp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 10:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264018AbTJ1Ptp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 10:49:45 -0500
Received: from [204.178.40.224] ([204.178.40.224]:38029 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264017AbTJ1Ptk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 10:49:40 -0500
Date: Tue, 28 Oct 2003 10:45:43 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Helge Hafting <helgehaf@aitel.hist.no>, Amir Hermelin <amir@montilio.com>,
       linux-kernel@vger.kernel.org
Subject: Re: how do file-mapped (mmapped) pages become dirty?
In-Reply-To: <3F9E8AB3.4070305@nortelnetworks.com>
Message-ID: <Pine.LNX.4.53.0310281042530.21561@chaos>
References: <006901c39d50$0b1313d0$2501a8c0@CARTMAN> <3F9E84A5.2060500@aitel.hist.no>
 <3F9E8AB3.4070305@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003, Chris Friesen wrote:

> Helge Hafting wrote:
> > Amir Hermelin wrote:
>
> >> What function is responsible for this setting? And when will the page be
> >> written back to disk (i.e. where's the flusher located)?
> >>
> > When there's memory pressure, or a sync.
>
> Note however that you need an msync() -- fsync() and fdatasync() do not
> catch changes to mmapped pages.
>
> Chris
>

Sure they do. fsync() will sync the whole file, regardless of
whether or not it's been mapped. msync()  allows you to sync
only a  specific portion and control how that portion is
handled with some flags.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


