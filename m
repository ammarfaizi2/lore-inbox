Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265356AbSJXIwK>; Thu, 24 Oct 2002 04:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265357AbSJXIwK>; Thu, 24 Oct 2002 04:52:10 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:37058 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265356AbSJXIwJ>; Thu, 24 Oct 2002 04:52:09 -0400
Subject: Re: writepage return value check in vmscan.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: chrisl@vmware.com, andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DB7B11B.9E552CFF@digeo.com>
References: <20021024082505.GB1471@vmware.com> 
	<3DB7B11B.9E552CFF@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Oct 2002 10:15:06 +0100
Message-Id: <1035450906.8675.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 09:36, Andrew Morton wrote:
> A few fixes have been discussed.  One way would be to allocate
> the space for the page when it is first faulted into reality and
> deliver SIGBUS if backing store for it could not be allocated.

You still have to handle the situation where the page goes walkies and
you get ENOSPC or any other ERANDOMSUPRISE from things like NFS. SIGBUS
appears the right thing to do.

