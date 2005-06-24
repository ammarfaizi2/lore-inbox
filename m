Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262993AbVFXDDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbVFXDDz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 23:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVFXDDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 23:03:53 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58347 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262993AbVFXDDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 23:03:44 -0400
Date: Thu, 23 Jun 2005 20:05:24 -0700
From: Paul Jackson <pj@sgi.com>
To: James Morris <jmorris@redhat.com>
Cc: mark.fasheh@oracle.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
       torvalds@osdl.org, akpm@osdl.org, wim.coekaerts@oracle.com, lmb@suse.de
Subject: Re: [RFC] [PATCH] OCFS2
Message-Id: <20050623200524.298a6ab4.pj@sgi.com>
In-Reply-To: <Xine.LNX.4.44.0506231358230.14123-100000@thoron.boston.redhat.com>
References: <20050518223303.GE1340@ca-server1.us.oracle.com>
	<Xine.LNX.4.44.0506231358230.14123-100000@thoron.boston.redhat.com>
Organization: SGI
X-Mailer: Sylpheed version 1.9.12 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James wrote:
> Any chance of splitting it out?

Responding to your post, but I guess it's really Oracle I'm asking:

On my first glance just now at the git-ocfs patch, I was surprised that
what seemed to be separable facilities were combined into one patch.  I
see a file system, a lock manager (is that what DLM stands for - please
spell out acronyms)  and a configuration file system.


+configfs/
+       - directory containing configfs documentation and example code.
  ...
+dlmfs.txt
+       - info on the userspace interface to the OCFS2 DLM.
  ...
+ocfs2.txt
+       - info and mount options for the OCFS2 clustered filesystem.


These combine to make a 45 thousand line patch.  That's a big patch.
Only the netdev and reiser4 patches (and the combined linus.patch)
are bigger.

Shouldn't these be 3 patches, or more?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
