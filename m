Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWCBA5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWCBA5x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 19:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWCBA5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 19:57:53 -0500
Received: from pat.uio.no ([129.240.130.16]:41659 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751218AbWCBA5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 19:57:52 -0500
Subject: Re: NFS doen't uniformly copy timestamps to server
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Paul Dickson <dickson@permanentmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060301173554.f2d18939.dickson@permanentmail.com>
References: <20060301173554.f2d18939.dickson@permanentmail.com>
Content-Type: text/plain
Date: Wed, 01 Mar 2006 16:57:43 -0800
Message-Id: <1141261063.26382.20.camel@netapplinux-10.connectathon.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.7, required 12,
	autolearn=disabled, AWL 1.25, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-01 at 17:35 -0700, Paul Dickson wrote:
> I think I first noticed this problem in late December (I wrote a script
> to get around it then).  If I attempt to copy the mtime with a file, it
> won't get transfered.  But I can set it later.
> 
> Within a NFS mount directory:
> 	cp -a file1 file2	# Timestamp not copied
> 	mv file1 file2 		# Timestamp not copied
> 	touch -r file1 file2	# Timestamp copied
> 
> I've looked through the man files for mount, exportfs, and exports and I
> don't see an option I'm over looking.  An ethereal dump shows the mtime
> being sent to the server and the server replying with NFS3_OK and the
> correct mtime, but the resulting file does not have the mtime applied.
> 
> More data is at:
>   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=183208
> 
> This currently happens with 2.6.16rc5-git3
> 
> Is this a problem with the NFS server or am I applying the wrong options?

The RedHat bugzilla tracks RedHat bugs. For kernel bugs, see
bugzilla.kernel.org.

>From your description, it looks very much like the issue being tracked
in

   http://bugzilla.kernel.org/show_bug.cgi?id=6127

Feel free to try the proposed patch.

Cheers,
  Trond

