Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbSJaUZL>; Thu, 31 Oct 2002 15:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263249AbSJaUZL>; Thu, 31 Oct 2002 15:25:11 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:417
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S263105AbSJaUZL>; Thu, 31 Oct 2002 15:25:11 -0500
Message-ID: <3DC1915E.8070502@rackable.com>
Date: Thu, 31 Oct 2002 12:23:58 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Reiser vs EXT3
References: <20021031141950.GM3420@rdlg.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2002 20:31:37.0301 (UTC) FILETIME=[82C80850:01C2811C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert L. Harris wrote:

>  Still working on that replacement mail server and a new rumor has hit
>the mix.  It follows that reiserfs is much faster than ext3 (made ext3,
>not converted from ext2 if it matters) and this is causing some
>problems.  On a 200Gig filesystem is this truely an issue?
>
>  
>

  Have you tried different ext3 journalling modes?  Ordered is pretty 
slow in many cases.  You might want to try writeback instead.  The 
downside is that you might end up losing resently written changes in the 
event of a crash.  Try mounting with "-o data=writeback".


