Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265418AbUGSUbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265418AbUGSUbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 16:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265502AbUGSUbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 16:31:24 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:13698 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S265418AbUGSUbW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 16:31:22 -0400
Date: Tue, 20 Jul 2004 00:31:48 +0200
From: sam@ravnborg.org
To: Steve Bangert <sbangert@mindspring.com>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: make rpm broken in 2.6.8-rc2
Message-ID: <20040719223148.GA9796@mars.ravnborg.org>
Mail-Followup-To: Steve Bangert <sbangert@mindspring.com>,
	sam@ravnborg.org, linux-kernel@vger.kernel.org
References: <40FBA5D2.90107@mindspring.com> <20040719152215.GA23344@mars.ravnborg.org> <40FC15CF.9090001@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FC15CF.9090001@mindspring.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>+ cd /usr/src/redhat/BUILD
> >>+ rm -rf kernel-2.6.8rc1
> >>+ /usr/bin/gzip -dc /usr/src/kernel-2.6.8rc1.tar.gz
> >>+ tar -xf -
> >>
> >>gzip: /usr/src/kernel-2.6.8rc1.tar.gz: unexpected end of file
> >>tar: Unexpected EOF in archive
> >>tar: Unexpected EOF in archive
> >>   
> >>
> >
> >tar is complaining here, even though it is reading from '-'.
> >Is it repeatable?
> > 
> >
> Yes, tried it 3 times, same result. I don,t think the "make spec" 
> script is being executed.

Could you try running
/bin/gzip -dc /home/sam/bk/kernel-2.6.8rc2.tar.gz | tar -xf -
in an empty directory.
If that fails try:
/bin/gzip -dc /home/sam/bk/kernel-2.6.8rc2.tar.gz 
eventually redirected to /dev/null


Also try to check the size of the .tar.gz file.
My tar.gz file:
 $ ll  /home/sam/bk/kernel-2.6.8rc2.tar.gz
 -rw-r--r--  1 sam users 153725342 Jul 20 00:17 /home/sam/bk/kernel-2.6.8rc2.tar.gz


If the .tar.gz file is broken try uncomenting the rm from the Makefile
and execute rpmbuild manually.

	Sam
