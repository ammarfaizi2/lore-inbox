Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267120AbTA0Dyg>; Sun, 26 Jan 2003 22:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267122AbTA0Dyg>; Sun, 26 Jan 2003 22:54:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:7066 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267120AbTA0Dyg>;
	Sun, 26 Jan 2003 22:54:36 -0500
Date: Sun, 26 Jan 2003 20:03:46 -0800
From: Andrew Morton <akpm@digeo.com>
To: Jason Howard <lists@spectsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kiovec/kiobuf replacement
Message-Id: <20030126200346.25f254e4.akpm@digeo.com>
In-Reply-To: <1043639121.1447.21.camel@bmagic.spectsoft.com>
References: <1043639121.1447.21.camel@bmagic.spectsoft.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2003 04:03:46.0610 (UTC) FILETIME=[170C5120:01C2C5B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Howard <lists@spectsoft.com> wrote:
>
> Hello All,
> 
> What is the correct change in code/mindset needed to replace the
> kiovec/kiobuf routines?  I am currently using there routines to do a
> scatter gather DMA from a user space buffer to/from a PCI video frame
> buffer device.  Should I approach this problem differently?  The user
> space buffer can be up to 8MB in size.
> 

Direct use of get_user_pages() seems to be working OK for that sort of thing.

