Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314987AbSE2LZY>; Wed, 29 May 2002 07:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315048AbSE2LZX>; Wed, 29 May 2002 07:25:23 -0400
Received: from pat.uio.no ([129.240.130.16]:20958 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S314987AbSE2LZW>;
	Wed, 29 May 2002 07:25:22 -0400
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: jw schultz <jw@pegasys.ws>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: wait queue process state
In-Reply-To: <3CF2A0FB.8090507@um.edu.mt>
	<1022572663.12203.127.camel@pc-16.office.scali.no>
	<20020528160143.G885@pegasys.ws> <20020528190518.E21009@redhat.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 29 May 2002 13:25:13 +0200
Message-ID: <shsd6vfqjqe.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Benjamin LaHaise <bcrl@redhat.com> writes:

     > Linux does not permit interrupting regular file reads on local
     > disks; only NFS supports it.  Maybe 2.5 is the time to change
     > this.

Note that even the NFS support is less than perfect. Once a process
enters lock_page(), there is no way for the user to interrupt until
whatever I/O that is holding the page lock is finished.

Cheers,
  Trond
