Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbULVO4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbULVO4p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 09:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbULVO4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 09:56:44 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:50879 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261775AbULVO4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 09:56:30 -0500
Date: Wed, 22 Dec 2004 15:56:28 +0100
From: bert hubert <ahu@ds9a.nl>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-cifs-client@lists.samba.org, linux-kernel@vger.kernel.org
Subject: Re: cifs large write performance improvements to Samba
Message-ID: <20041222145628.GA5727@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Steve French <smfrench@austin.rr.com>,
	linux-cifs-client@lists.samba.org, linux-kernel@vger.kernel.org
References: <1102916738.5937.48.camel@smfhome.smfdom> <20041213143831.GA3743@outpost.ds9a.nl> <41BDC911.9010600@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BDC911.9010600@austin.rr.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 10:53:37AM -0600, Steve French wrote:
> 
> The current mainline (very recent 2.6.10-rc Linux tree) should be fine 
> from memory leak perspective.  No such leaks have been reported AFAIK on 
> current cifs code and certainly none that I have detected in heavy 
> stress testing. 

Indeed, thank you Steve! I had not noticed this progression from the
changelog messages. I've since verified on a multimillion file share that
cifs indeed shrinks the cifs_inode_cache under memory pressure. I've turned
on updatedb again, hope that the box survives it now.

> On the issue of regressing back to smbfs :)  There are a few things 
> which can be done that would help.

I've since moved some stuff back to cifs to see what happens. I'll try to
convince some other people so they can share/report their problems properly.

> 2) Public view of the status of testing - the raw data needs to be 
> posted regularly as kernel updated (and against five or six different 
> server types) so users see what is broken in smbfs (and so users can see 
> what posix issues are still being worked on cifs and any known 
> problems).   smbfs fails about half of the filesystem tests that I have 
> tried, due to stress issues, or because the tests requires better posix 
> compliance or because of various smbfs stability fixes.

That may be so but the definite perception is that cifs is unstable compared
to smbfs. Then again, this may have been related to out of memory conditions
which generaly tend to make things suck.

Thanks for your thoughtful reply, I'll see if I can provide useful feedback.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
