Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUGSNV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUGSNV4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 09:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUGSNVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 09:21:55 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:18296 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265224AbUGSNVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 09:21:54 -0400
Date: Mon, 19 Jul 2004 17:22:15 +0200
From: sam@ravnborg.org
To: Steve Bangert <sbangert@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make rpm broken in 2.6.8-rc2
Message-ID: <20040719152215.GA23344@mars.ravnborg.org>
Mail-Followup-To: Steve Bangert <sbangert@mindspring.com>,
	linux-kernel@vger.kernel.org
References: <40FBA5D2.90107@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FBA5D2.90107@mindspring.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works for me..

On Mon, Jul 19, 2004 at 03:43:30AM -0700, Steve Bangert wrote:
> [root@localhost linux-2.6]# make rpm
> make clean
> set -e; cd ..; ln -sf /usr/src/linux-2.6 kernel-2.6.8rc2
> set -e; cd ..; tar -cz  -f kernel-2.6.8rc2.tar.gz kernel-2.6.8rc2/.
> set -e; cd ..; rm kernel-2.6.8rc2
> set -e; \
> /bin/sh /usr/src/linux-2.6/scripts/mkversion > 
> /usr/src/linux-2.6/.tmp_version
> set -e; \
> mv -f /usr/src/linux-2.6/.tmp_version /usr/src/linux-2.6/.version
> rpmbuild --target i386 -ta ../kernel-2.6.8rc2.tar.gz
> Building target platforms: i386
> Building for target i386
> Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.72624
> + umask 022
> + cd /usr/src/redhat/BUILD
> + LANG=C
> + export LANG
These two lines are not present here. Maybe that have impact?

> + cd /usr/src/redhat/BUILD
> + rm -rf kernel-2.6.8rc1
> + /usr/bin/gzip -dc /usr/src/kernel-2.6.8rc1.tar.gz
> + tar -xf -
> 
> gzip: /usr/src/kernel-2.6.8rc1.tar.gz: unexpected end of file
> tar: Unexpected EOF in archive
> tar: Unexpected EOF in archive

tar is complaining here, even though it is reading from '-'.
Is it repeatable?

	Sam
