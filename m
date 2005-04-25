Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbVDYJ4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVDYJ4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 05:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbVDYJ4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 05:56:14 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:9883 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262571AbVDYJ4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 05:56:00 -0400
To: linuxram@us.ibm.com
CC: jamie@shareable.org, viro@parcelfarce.linux.theplanet.co.uk,
       hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-reply-to: <1114411302.4480.70.camel@localhost> (message from Ram on Sun, 24
	Apr 2005 23:41:42 -0700)
Subject: Re: [PATCH] private mounts
References: <E1DPnOn-0000T0-00@localhost>
	 <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost>
	 <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk>
	 <E1DPoCg-0000W0-00@localhost>
	 <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk>
	 <20050424213822.GB9304@mail.shareable.org>
	 <E1DPwdo-0006xF-00@dorka.pomaz.szeredi.hu> <1114411302.4480.70.camel@localhost>
Message-Id: <E1DQ0JK-0007AQ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 25 Apr 2005 11:55:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have not yet sure how invisible mount can be used to solve the FUSE
> problem.  
> 
> Again my understanding of the basic requirement of FUSE is:
> 
> 1. A user being able to setup his own VFS-mount environment which
>   	 is only visible to the user. 
> 2. The same user being able to see exactly the same VFS-mount  
> 	environment from any login session.

More generally: 

1. the files exported by the FUSE filesystem should not be accessible
   by other users.

2. The user should see exactly the same files from any login session.

These can be satisfied in various ways.  Permission checking, or by
making FUSE mounts invisible to other users, or with private
namespaces (in increasing complexity).

Thanks,
Miklos
