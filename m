Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbTDHXTr (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 19:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbTDHXTr (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 19:19:47 -0400
Received: from [12.47.58.221] ([12.47.58.221]:39148 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262587AbTDHXTq (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 19:19:46 -0400
Date: Tue, 8 Apr 2003 15:29:56 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Tomasz Torcz, BG" <zdzichu@irc.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.67] buffer layer error at fs/buffer.c:127; problems with
 via686a sensor
Message-Id: <20030408152956.21b09f3a.akpm@digeo.com>
In-Reply-To: <20030408162118.GA10209@irc.pl>
References: <20030408162118.GA10209@irc.pl>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Apr 2003 23:31:19.0235 (UTC) FILETIME=[F4FED930:01C2FE26]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tomasz Torcz, BG" <zdzichu@irc.pl> wrote:
>
> Hi,
> 
> infos about my system is here: http://fordon.pl.eu.org/~zdzichu/my_setup/
> (lspci, output of some files from /proc, dmesg and .config).
> 
> I've got some unexplained Call Traces in dmesg:
> 
> buffer layer error at fs/buffer.c:127

That's not a bug.  It is errant debugging code.  reiserfs has locked the
page, so the buffers are safe.


