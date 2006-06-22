Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161147AbWFVO3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbWFVO3L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbWFVO3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:29:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49883 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161147AbWFVO3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:29:08 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <15603.1150978967@warthog.cambridge.redhat.com> 
References: <15603.1150978967@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: neilb@suse.de, balbir@in.ibm.com, akpm@osdl.org, aviro@redhat.com,
       jblunck@suse.de, dev@openvz.org, olh@suse.de,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Fix dcache race during umount 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 22 Jun 2006 15:27:57 +0100
Message-ID: <11117.1150986477@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> I'd like to propose an alternative to your patch to fix the dcache race
> between unmounting a filesystem and the memory shrinker.
> 
> In my patch, generic_shutdown_super() is made to call shrink_dcache_sb()
> instead of shrink_dcache_anon(), and the latter function is discarded
> completely since it's no longer used.

On the other hand, I can make my patch just alter the effect of yours.

David
