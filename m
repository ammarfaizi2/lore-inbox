Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVBXEeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVBXEeT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVBXEcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:32:08 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:13283 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261812AbVBXESv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:18:51 -0500
Subject: Re: ext2/3 files per directory limits
From: Lee Revell <rlrevell@joe-job.com>
To: Ron Peterson <rpeterso@mtholyoke.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050224031107.GA8656@mtholyoke.edu>
References: <20050224031107.GA8656@mtholyoke.edu>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 23:18:50 -0500
Message-Id: <1109218730.4957.14.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-23 at 22:11 -0500, Ron Peterson wrote:
> I would like to better understand ext2/3's performance characteristics.
> 
> I'm specifically interested in how ext2/3 will handle a /var/spool/mail
> directory w/ ~6000 mbox format inboxes, handling approx 1GB delivered as
> 75,000 messages daily.  Virtually all access is via imap, w/ approx
> ~1000 imapd processes running during peak load.  Local delivery is via
> procmail, which by default uses both kernel-supported locking calls and
> .lock files.
> 
> I understand that various tuning parameters will have an impact,
> e.g. putting the journal on a separate device, setting the noatime mount
> option, etc.  I also understand that there are other mailbox formats and
> other strategies for locating mail spools (e.g. in user's home
> directories).
> 
> I'm interested in people's thoughts on these issues, but I'm mostly
> interested in whether or not the scenario I described falls within
> ext2/3's designed capabilities.

Yes, ext2 and ext3 can handle that load easily.  You should not have to
do any special tuning.

The real question is why in the world you would want to use mbox format
for this.  It simply does not scale.  Use maildir.

Lee

