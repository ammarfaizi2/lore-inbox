Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWGDHTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWGDHTi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWGDHTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:19:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48577 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751108AbWGDHTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:19:38 -0400
Date: Tue, 4 Jul 2006 00:19:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: mp3@de.ibm.com, clg@fr.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch] statistics infrastructure - update 9
Message-Id: <20060704001926.20889847.akpm@osdl.org>
In-Reply-To: <20060704061754.GB9417@osiris.boeblingen.de.ibm.com>
References: <1151943862.2936.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	<20060704061754.GB9417@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2006 08:17:54 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> > +
> > +static inline void statistic_add_as(int type, struct statistic *stat, int i,
> > +				    s64 value, u64 incr)
> > +{
> > +}
> > +
> > +#endif /* CONFIG_STATISTICS */
> 
> Why not have something like:
> 
> #define statistic_create(interface, name) 	({ 0; })
> #define statistic_remove(interface)		({ 0; })
> #define statistic_set(stat, i, value, total)	do { } while (0)
> ...
> 
> That would be much shorter and easier to read. But maybe it's just me :)

typechecking.

	struct scsi_device s;
	int foo;

	statistic_create(s, foo_with_a_typo);	/* whee */

