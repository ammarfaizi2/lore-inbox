Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263498AbTHWKSf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 06:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTHWKSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 06:18:35 -0400
Received: from 217-124-19-86.dialup.nuria.telefonica-data.net ([217.124.19.86]:43140
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S263498AbTHWKSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 06:18:33 -0400
Date: Sat, 23 Aug 2003 12:18:31 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: evms or lvm?
Message-ID: <20030823101831.GA2857@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3F47347F.7070103@mscc.huji.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F47347F.7070103@mscc.huji.ac.il>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 23 August 2003, at 12:31:43 +0300,
Voicu Liviu wrote:

> I'm planing to move to 2.6x kernels and I don't know what should I use,
> lvm or evms, any 1 could help me to decide?
> I've heard that evms will not continue with 2.6, is it true?
> Best regards
> 
2.6.0 will have many changes with respect to LVM and EVMS. LVM is
updated to newer version 2 (LVM2), based on DM (Device Mapper), sort of
a simplified in-kernel LVM that just handles discovering the drives.
Updated userspace utilities (LVM2) are already available to drive this.

On the other part, EVMS was completely redesigned. Former EVMS
implementation was duplicating too much code, and in general it was
regarded as a bad implementation on a very good idea, so the people at
IBM in charge on EVMS development took what it look to everyone as a
very clever move, and for 2.6.x they implemented EVMS on top of DM. User
space utilities for EVMS are (from the user's point of view) the same as
before, but now the inner details are different: no reimplementation of
software RAID, no reimplementation of LVM, etc.

Have a look at both projects websites to get more accurate and detailled
information about them:
http://evms.sourceforge.net/
http://www.sistina.com/products_lvm.htm

Regards,

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test3-mm2)
