Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262966AbTCSKu0>; Wed, 19 Mar 2003 05:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262967AbTCSKuZ>; Wed, 19 Mar 2003 05:50:25 -0500
Received: from mail.ithnet.com ([217.64.64.8]:12819 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S262966AbTCSKuZ>;
	Wed, 19 Mar 2003 05:50:25 -0500
Date: Wed, 19 Mar 2003 12:01:14 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
       green@namesys.com
Subject: Re: kernel nfsd
Message-Id: <20030319120114.6839f464.skraw@ithnet.com>
In-Reply-To: <15991.39213.798975.721205@notabene.cse.unsw.edu.au>
References: <20030318155731.1f60a55a.skraw@ithnet.com>
	<15991.15327.29584.246688@charged.uio.no>
	<20030318164204.03eb683f.skraw@ithnet.com>
	<15991.39213.798975.721205@notabene.cse.unsw.edu.au>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003 09:09:49 +1100
Neil Brown <neilb@cse.unsw.edu.au> wrote:

> Maybe this is reiserfs specific.  Has anyone seen it on a non-reiserfs
> filesystem?  Possibly reiserfs does something funny with inode numbers
> that is confusing the name lookup.
> 
> If it doesn't seem to correlate with other symptoms, I probably
> wouldn't worry about it.

I re-checked the logfile and it looks like the read request (or open request)
is in fact failing, so something should be done. The apache-log looks like:

[Mon Mar 17 22:55:56 2003] [crit] [client w.x.y.z] (17)File exists: /a/b/c/d/e
pcfg_openfile: unable to check htaccess file, ensure it is readable

The corresponding nfs message is:

Mar 17 22:55:55 me kernel: nfsd-fh: found a name that I didn't expect: c/d

-- 
Regards,
Stephan
