Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTJXFNw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 01:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbTJXFNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 01:13:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:43926 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262009AbTJXFNv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 01:13:51 -0400
Date: Thu, 23 Oct 2003 22:17:56 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: jtholmes@jtholmes.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8  scsi logging not working
Message-ID: <20031024051755.GD1133@beaverton.ibm.com>
Mail-Followup-To: jtholmes@jtholmes.com, linux-kernel@vger.kernel.org
References: <102420030310.18374.4e89@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102420030310.18374.4e89@comcast.net>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jtholmesjr@comcast.net [jtholmesjr@comcast.net] wrote:
> The problem:
> 
> I thought
> echo "scsi log all" >/proc/scsi/scsi 
> with
> scsi_logging=y  in .config
> would turn on kernel scsi logging and put some notification line
> in /var/log/messages
> indicating scsi logging was now active at such and such a level
> 
> that is not happening and I have a external drive connected via
> usb talking scsi that cannot be unmounted and i need to trace
> scsi action so I can post here.
> 
> lsscsi output is
> [0:0:0:0]    disk    USB 2.0  Storage Device   0100  /dev/sda
> [1:0:0:0]    disk    Linux    scsi_debug       0004  /dev/sdb
> 

The scsi logging interface switched control from proc to sysctl. 

sysctl -w dev.scsi.logging_level=0xffffffff

Will result in a scsi log all. You need to use caution if syslogd is
running and you have other scsi devices.

-andmike
--
Michael Anderson
andmike@us.ibm.com

