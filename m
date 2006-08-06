Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWHFALL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWHFALL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 20:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWHFALK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 20:11:10 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:45682 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751435AbWHFALI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 20:11:08 -0400
Date: Sat, 5 Aug 2006 17:11:05 -0700
From: Chris Wedgwood <cw@f00f.org>
To: dean gaudet <dean@arctic.org>
Cc: David Lang <dlang@digitalinsight.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Valerie Henson <val_henson@linux.intel.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Jesse Barnes <jesse.barnes@intel.com>, jsipek@cs.sunysb.edu,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] [PATCH] Relative lazy atime
Message-ID: <20060806001105.GA20715@tuatara.stupidest.org>
References: <20060803063622.GB8631@goober> <20060805122537.GA23239@lst.de> <1154797123.12108.6.camel@kleikamp.austin.ibm.com> <1154797475.3054.79.camel@laptopd505.fenrus.org> <20060805183609.GA7564@tuatara.stupidest.org> <20060805222247.GQ29686@ca-server1.us.oracle.com> <Pine.LNX.4.63.0608051604420.20114@qynat.qvtvafvgr.pbz> <Pine.LNX.4.64.0608051612330.20926@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608051612330.20926@twinlark.arctic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 04:28:29PM -0700, dean gaudet wrote:

> i can't understand when atime is *ever* reliable... root doing
> backups with something like rsync will cause atimes to change.

well, rsync and friends could use O_NOATIME, but usually that isn't
worth the pain

> you can work around mutt's silly dependancy on atime by configuring
> it with --enable-buffy-size.  so far mutt is the only program i've
> discovered which cares about atime.

i've seen other applications use it, but most are pretty tolerant
about it not working that way you might think it would

> also -- i wasn't aware that xfs tried to do a better job with atime
> updates... i'm not sure it's really that effective.  i've got a
> busy shell/mail/web server

OT, you might fine ikeep helps a little
