Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUK3DWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUK3DWh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 22:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbUK3DWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 22:22:36 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:30662 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261943AbUK3DWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 22:22:32 -0500
Subject: Re: 2.6.10-rc2-mm2 usb storage still oopses
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, cova@ferrara.linux.it,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20041129163231.33affbde.akpm@osdl.org>
References: <200411182203.02176.cova@ferrara.linux.it>
	<20041118133557.72f3b369.akpm@osdl.org>
	<20041118135809.3314ce41@lembas.zaitcev.lan>
	<200411190042.41199.cova@ferrara.linux.it>
	<20041118155542.324f56c7@lembas.zaitcev.lan> 
	<20041129163231.33affbde.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Nov 2004 21:22:03 -0600
Message-Id: <1101784930.2022.116.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-29 at 18:32, Andrew Morton wrote:
> Pete Zaitcev <zaitcev@redhat.com> wrote:
> >
> > On Fri, 19 Nov 2004 00:42:40 +0100, Fabio Coatti <cova@ferrara.linux.it> wrote:
> > 
> > > Nov 18 20:33:05 kefk kernel: sdb: assuming drive cache: write through
> > > Nov 18 20:33:05 kefk kernel:  sdb: sdb1
> > > Nov 18 20:33:05 kefk kernel:  sdb: sdb1
> > > Nov 18 20:33:05 kefk kernel: kobject_register failed for sdb1 (-17)
> > 
> > This looks as if SCSI falls victim of the general problem which ub addresses
> > with the following fragment:
> 
> Guys, is this problem still present in Linus's tree?  If so, is a fix for
> 2.6.10 looking feasible?

Al Viro has a tentative one at

http://ftp.linux.org.uk/pub/people/viro/register_disk-hack

If someone could try it out and verify that it fixes the problem, we
could put it in.

James


