Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbSAUKUc>; Mon, 21 Jan 2002 05:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280588AbSAUKUW>; Mon, 21 Jan 2002 05:20:22 -0500
Received: from penguin-ext.wise.edt.ericsson.se ([194.237.142.110]:52465 "EHLO
	penguin-ext.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S276424AbSAUKUM>; Mon, 21 Jan 2002 05:20:12 -0500
From: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi)
Date: Mon, 21 Jan 2002 11:18:25 +0100 (MET)
Message-Id: <200201211018.LAA08707@duna207.danubius>
To: pavel@suse.cz
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        avfs@fazekas.hu
In-Reply-To: <20020113031052.I511@toy.ucw.cz> (message from Pavel Machek on
	Sun, 13 Jan 2002 03:10:53 +0000)
Subject: Re: [ANNOUNCE] FUSE: Filesystem in Userspace 0.95
In-Reply-To: <200201100955.KAA19208@duna207.danubius> <20020113031052.I511@toy.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel!

> Are you multithreaded? Like will big ftp download block all FUSE, all ftp,
> only one server, or everything?

FUSE and AVFS are both multithreaded.  Specifically ftp is quite well
threaded, and a big download will not block any operation, even on the
same server. 

> >        o user can intentionally block the page writeback operation,
> >          causing a system lockup.  I'm not sure this can be solved in
> >          a truly secure way.  Ideas?
> 
> How does GRUB solve this?

What GRUB? 

> Maybe it could replace sf/coda and fs/intermezzo? Is it powerfull/fast
> enough for that?

No, at the moment there are a few features missing in FUSE, that CODA
needs (access caching, reading directly from files, file
reintegration).  But it is perfectly possible to add these features to
FUSE if somebody wants them. 

Actually having real disk files as a backing store for virtual files
could be the solution to the page writeback problem.  The only
question is how to manage this in an efficient way.

Miklos
