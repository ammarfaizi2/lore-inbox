Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbTHaLuy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 07:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbTHaLuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 07:50:54 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:9944 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261274AbTHaLux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 07:50:53 -0400
Date: Sun, 31 Aug 2003 13:50:50 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Andrea VM changes
Message-ID: <20030831115050.GC30252@merlin.emma.line.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0308301248380.31588@freak.distro.conectiva> <Pine.LNX.4.55L.0308301607540.31588@freak.distro.conectiva> <Pine.LNX.4.55L.0308301618500.31588@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0308301618500.31588@freak.distro.conectiva>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Aug 2003, Marcelo Tosatti wrote:

> 05_vm_09_misc_junk-3 removes the PF_MEMDIE and you also seem to remove the
> OOM killer. Is that right? Why?

Nuking OOM killer is IMHO a sane thing to do. Unless you start
everything out of PID #1 which is unkillable, usually init(8), you don't
want the OOM killer. Imagine it nukes your portmap. With Linux portmap
that doesn't support warm starts (unlike Solaris 8), this means: reboot.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
