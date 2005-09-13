Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbVIMRCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbVIMRCe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbVIMRCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:02:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30383 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964905AbVIMRCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:02:32 -0400
Date: Tue, 13 Sep 2005 10:01:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
cc: Sripathi Kodi <sripathik@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, patrics@interia.pl,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
In-Reply-To: <20050913165102.GR25261@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0509131000040.3351@g5.osdl.org>
References: <4325BEF3.2070901@in.ibm.com> <20050912134954.7bbd15b2.akpm@osdl.org>
 <4326CFE2.6000908@in.ibm.com> <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org>
 <20050913165102.GR25261@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Sep 2005, Al Viro wrote:
> 
> What we need is to decide what kind of access control do we really want on
> /proc/<pid>/task.  That's it.

I don't think any controls at all. The real control should then be on the
/proc/<pid>/task/<tid> access, which should be the same as the /proc/<pid>
controls (except for thread <tid> rather than thread <pid>, of course)

		Linus
