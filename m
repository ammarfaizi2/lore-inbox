Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbSJQMzW>; Thu, 17 Oct 2002 08:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261731AbSJQMzW>; Thu, 17 Oct 2002 08:55:22 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:44043 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261723AbSJQMzU>;
	Thu, 17 Oct 2002 08:55:20 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Srihari Vijayaraghavan <harisri@bigpond.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre11aa1 
In-reply-to: Your message of "Thu, 17 Oct 2002 14:10:05 +0200."
             <20021017141005.A8863@oldwotan.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Oct 2002 23:01:07 +1000
Message-ID: <15355.1034859667@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002 14:10:05 +0200, 
Andrea Arcangeli <andrea@suse.de> wrote:
>please try to find which is this module, replace modprobe with a script
>that does:
>
>#!/bin/sh
>echo $@ >>/tmp/log
>sync
>modprobe.orig $@

You don't need that, just mkdir /var/log/ksymoops.  modprobe/insmod
will create a daily log file and snapshot a copy of lsmod and
/proc/ksyms for every module loaded or unloaded.  All with sync in the
right places.

