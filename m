Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVESQTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVESQTU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 12:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbVESQTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 12:19:19 -0400
Received: from smtp.istop.com ([66.11.167.126]:59620 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262555AbVESQTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 12:19:13 -0400
From: Daniel Phillips <phillips@istop.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: [RFC] [PATCH] OCFS2
Date: Thu, 19 May 2005 12:23:15 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, torvalds@osdl.org, akpm@osdl.org,
       wim.coekaerts@oracle.com, lmb@suse.de
References: <20050518223303.GE1340@ca-server1.us.oracle.com> <200505190230.23624.phillips@istop.com> <20050519065405.GI1340@ca-server1.us.oracle.com>
In-Reply-To: <20050519065405.GI1340@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505191223.16189.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thursday 19 May 2005 02:54, Mark Fasheh wrote:
> On Thu, May 19, 2005 at 02:30:23AM -0400, Daniel Phillips wrote:
> > Zero terminated strings for lock names is bad taste.  It generates a
> > bunch of useless strlen executions and you force an ascii namespace for
> > no apparent reason.  Add a 9th parameter, namelen, to the lock call
> > maybe?
>
> Or perhaps pass in a qstr? Anyway I have to agree. That shouldn't be
> difficult to fix up.

Qstr would be nice, either that or an explicit string length.  Either way, the 
compiler will catch any missed fixups.

Regards,

Daniel

