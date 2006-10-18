Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbWJROne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbWJROne (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbWJROne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:43:34 -0400
Received: from sbexim0.cs.sunysb.edu ([130.245.1.149]:46026 "EHLO
	sbexim0.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1161042AbWJROnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:43:33 -0400
Date: Wed, 18 Oct 2006 10:39:13 -0400
Message-Id: <200610181439.k9IEdD1u029773@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Al Viro <viro@ftp.linux.org.uk>, Paul Jackson <pj@sgi.com>, akpm@osdl.org,
       jsipek@fsl.cs.sunysb.edu, linux-kernel@vger.kernel.org,
       hch@infradead.org, mhalcrow@us.ibm.com, penberg@cs.helsinki.fi,
       linux-fsdevel@vger.kernel.org
Subject: Re: fsstack: struct path 
In-reply-to: Your message of "Wed, 18 Oct 2006 12:56:45 +0200."
             <20061018105645.GA20542@wohnheim.fh-wedel.de> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IMHO, the string "path" is so generic (and nice, short, and sweet :-), that
only higher-level layers such as the VFS should be allowed to define it.
All other layers that are somewhere below the VFS (drivers/md/dm-mpath.h and
reiserfs), should rename their struct path to something more specific.  If
anyone component can claim "first rights" for the name "struct path" -- it's
the VFS.

That said, 'pathnode' is also good, esp. if it better describes the contents
and use of this struct.  But I would still rename all other uses of 'struct
path' below the VFS.

Erez.
