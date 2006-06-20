Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWFTDpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWFTDpV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 23:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWFTDpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 23:45:21 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:64429 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932537AbWFTDpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 23:45:20 -0400
Date: Tue, 20 Jun 2006 12:46:10 +0900
From: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: vgoyal@in.ibm.com, Preben.Trarup@ericsson.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kdump: add a missing notifier before
 crashing
Message-Id: <20060620124610.79c4f5a1.akiyama.nobuyuk@jp.fujitsu.com>
In-Reply-To: <m1zmg9ghlr.fsf@ebiederm.dsl.xmission.com>
References: <20060615201621.6e67d149.akiyama.nobuyuk@jp.fujitsu.com>
	<m1d5d9pqbr.fsf@ebiederm.dsl.xmission.com>
	<20060616211555.1e5c4af0.akiyama.nobuyuk@jp.fujitsu.com>
	<m1odwtnjke.fsf@ebiederm.dsl.xmission.com>
	<20060619163053.f0f10a5e.akiyama.nobuyuk@jp.fujitsu.com>
	<m1y7vtia7r.fsf@ebiederm.dsl.xmission.com>
	<4496A677.3020301@ericsson.com>
	<m1hd2hhyzn.fsf@ebiederm.dsl.xmission.com>
	<20060619170711.GB8172@in.ibm.com>
	<m1zmg9ghlr.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 11:50:24 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> > On Mon, Jun 19, 2006 at 10:49:32AM -0600, Eric W. Biederman wrote:
> >
> > Sounds like trouble for modules. I am assuming that code to power down the
> > scsi disks/controller will be part of the driver, which is generally built
> > as a module and also assuming that powering down the disks is a valid
> > requirement after the crash.
> 
> I'm assuming if anything is important and critical enough to be in a crash
> notifier it can be built into the kernel.

No. On enterprise system, commercial distributions are generally
used and we can not usually modify the kernel code.
So that is the reason why I need generic add-on hook.
I have put a actual usage, and Preben also. I think it is difficult
to define precise characteristic of the notifier at the desk.

Thanks,
--
Akiyama, Nobuyuki

