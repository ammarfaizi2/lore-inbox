Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbUKRRiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbUKRRiD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbUKRR2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:28:55 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:31113 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262779AbUKRRQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:16:14 -0500
In-Reply-To: <E1CUhTd-0006c8-00@dorka.pomaz.szeredi.hu>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz, torvalds@osdl.org
MIME-Version: 1.0
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Thu, 18 Nov 2004 09:12:59 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M2_07222004 Beta 2|July
 22, 2004) at 11/18/2004 12:16:09,
	Serialize complete at 11/18/2004 12:16:09
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) not allowing share writable mappings 
>...
>In the first case there will never be dirty data, since normal writes
>go synchronously through the page cache.

A normal write is a VFS write() call, I assume.  While they're going 
through the page cache, the pages are dirty, right?  Is it possible that 
FUSE needs more real memory after dirtying those pages in order to finish 
cleaning them?

What about the 3rd case: private writable mapping?  How does that work?

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems
