Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbTJ2EXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 23:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTJ2EXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 23:23:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34982 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261831AbTJ2EXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 23:23:19 -0500
Date: Wed, 29 Oct 2003 04:23:18 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ernst Herzberg <earny@net4u.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 can't kill process in stat 'R'
Message-ID: <20031029042318.GY7665@parcelfarce.linux.theplanet.co.uk>
References: <200310290508.41096.earny@net4u.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310290508.41096.earny@net4u.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 05:08:40AM +0100, Ernst Herzberg wrote:
> lidl /proc/acpi # kill -9 3661
> lidl /proc/acpi # ps ax|grep klaptopdaemon
>  3661 ?        R    808:27 kdeinit: klaptopdaemon
>  5033 pts/1    S      0:00 grep klaptopdaemon

So it sits in kernel mode in running state and doesn't want to leave.
Say Alt-SysRq-T and see what's in the stack trace of that process -
that will show where it's spinning...
