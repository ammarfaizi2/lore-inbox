Return-Path: <linux-kernel-owner+w=401wt.eu-S1753411AbWLOUcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbWLOUcN (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbWLOUcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:32:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:42100 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753411AbWLOUcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:32:12 -0500
Date: Fri, 15 Dec 2006 12:31:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jean Delvare <khali@linux-fr.org>, Olivier Galibert <galibert@pobox.com>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sysfs file creation result nightmare
Message-Id: <20061215123103.adfbd78b.akpm@osdl.org>
In-Reply-To: <1166213773.31351.96.camel@localhost.localdomain>
References: <20061209165606.2f026a6c.khali@linux-fr.org>
	<1165694351.1103.133.camel@localhost.localdomain>
	<20061209123817.f0117ad6.akpm@osdl.org>
	<20061209214453.GA69320@dspnet.fr.eu.org>
	<20061209135829.86038f32.akpm@osdl.org>
	<20061209223418.GA76069@dspnet.fr.eu.org>
	<20061209145303.3d5fe141.akpm@osdl.org>
	<1165712131.1103.166.camel@localhost.localdomain>
	<20061215154751.86a2dbdd.khali@linux-fr.org>
	<1166213773.31351.96.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006 07:16:13 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > Beware that sysfs_remove_bin_file() will complain loudly if you later
> > attempt to delete that file that was never created.
> 
> That's another problem... what is a driver that creates 15 files
> supposed to do ? Have 15 booleans to remember which files where
> successfully created and then test all of them on cleanup ? That sounds
> like even more bloat to me...

That's the sort of thing which should be done inside sysfs_create_group()
and sysfs_remove_group().
