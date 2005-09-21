Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbVIUWDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbVIUWDn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 18:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbVIUWDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 18:03:43 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:24656 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965102AbVIUWDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 18:03:42 -0400
To: "Christopher Friesen" <cfriesen@nortel.com>
Cc: dipankar@in.ibm.com, Sonny Rao <sonny@burdell.org>,
       linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
       bharata@in.ibm.com, viro@ftp.linux.org.uk, trond.myklebust@fys.uio.no
Subject: Re: dentry_cache using up all my zone normal memory -- also seen on
 2.6.14-rc2
X-Message-Flag: Warning: May contain useful information
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com>
	<4331B89B.3080107@nortel.com>
	<20050921200758.GA25362@kevlar.burdell.org>
	<4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com>
	<4331CFAD.6020805@nortel.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 21 Sep 2005 15:03:33 -0700
In-Reply-To: <4331CFAD.6020805@nortel.com> (Christopher Friesen's message of
 "Wed, 21 Sep 2005 15:25:01 -0600")
Message-ID: <52ll1qkrii.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 21 Sep 2005 22:03:34.0904 (UTC) FILETIME=[4FBF6F80:01C5BEF8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Christopher> Digging in a bit more, it looks like the files are
    Christopher> being created/destroyed/renamed in /tmp, which is a
    Christopher> tmpfs filesystem.

Hmm... could there be a race in shmem_rename()??

 - R.
