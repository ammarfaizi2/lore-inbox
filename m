Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261777AbSJDODW>; Fri, 4 Oct 2002 10:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261778AbSJDODV>; Fri, 4 Oct 2002 10:03:21 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:39186 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261777AbSJDODU>; Fri, 4 Oct 2002 10:03:20 -0400
Date: Fri, 4 Oct 2002 15:08:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mark Peloquin <peloquin@us.ibm.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 2/4: evms.h
Message-ID: <20021004150849.A30635@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Peloquin <peloquin@us.ibm.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <OF6E4A0115.7A4BB6D7-ON85256C47.0059EE6F@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF6E4A0115.7A4BB6D7-ON85256C47.0059EE6F@pok.ibm.com>; from peloquin@us.ibm.com on Thu, Oct 03, 2002 at 12:42:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 12:42:23PM -0500, Mark Peloquin wrote:
> >> +#define TRUE                            1
> 
> > Please just use 0/1 directly just like everyone else..
> 
> More than happy to comply, however grep'ing the tree its
> plain to see that not "everyone else" is following this
> suggestion.

Sure there are other offenders in the drivers, from known offenders like
Richard or IBM, but no core code.  There is a reason why theses defines are
not in kernel.h..

> 
> >> +#define DEV_PATH                "/dev"
> >> +#define EVMS_DIR_NAME                 "evms"
> >> +#define EVMS_DEV_NAME                 "block_device"
> >> +#define EVMS_DEV_NODE_PATH            DEV_PATH "/" EVMS_DIR_NAME "/"
> >> +#define EVMS_DEVICE_NAME        DEV_PATH "/" EVMS_DIR_NAME "/"
> EVMS_DEV_NAME
> 
> > The kernel doesn't know about device names at all.
> 
> I realize this is a goal, and I'm not opposed to it. However,
> I know devfs is not popular, but people are using it, and it
> *is* still available in 2.5. For the cases where ppl are
> using it, the EVMS kernel component needs this info to tell
> devfs the name of the devnode to create. I don't want to get
> into a devfs flamewar, EVMS is simply offering interoperability
> with what ppl n do today. Should that change, EVMS is more
> than happy to adapt to the latest technology.

You can"t know where devfs is mounted.  So of the above only EVMS_DIR_NAME
and EVMS_DEV_NAME make sense.

