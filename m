Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbTJKTkO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 15:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTJKTkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 15:40:14 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:16140 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263378AbTJKTkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 15:40:11 -0400
Date: Sat, 11 Oct 2003 21:40:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "David S. Miller" <davem@redhat.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: patches for PROC_FS=n (2.6.0-test7)
Message-ID: <20031011194008.GA2395@mars.ravnborg.org>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
References: <20031010141646.779f10bb.rddunlap@osdl.org> <20031011120852.13fa8ec4.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011120852.13fa8ec4.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 11, 2003 at 12:08:52PM -0700, David S. Miller wrote:
> On Fri, 10 Oct 2003 14:16:46 -0700
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> 
> > http://developer.osdl.org/rddunlap/patches/atmprocfs_260t7.patch
> 
> How can this be needed?  When procfs is disabled then
> remove_proc_entry() is defined as "do { } while (0)", ie. a nop.

Due to this - the real offender:

from: net/atm/clip.c:
#ifdef CONFIG_PROC_FS
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#endif

	Sam
