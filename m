Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317489AbSGJGbS>; Wed, 10 Jul 2002 02:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317491AbSGJGbR>; Wed, 10 Jul 2002 02:31:17 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:35723 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S317489AbSGJGbP>; Wed, 10 Jul 2002 02:31:15 -0400
Date: Wed, 10 Jul 2002 08:33:46 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
Message-ID: <20020710063346.GD32293@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org
References: <200207091549.15913.trond.myklebust@fys.uio.no> <Pine.LNX.3.95.1020709095544.27285A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020709095544.27285A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 10:06:45AM -0400, Richard B. Johnson wrote:
> I think code that opens a directory as a file is broken. We have
> opendir() for that and it returns a DIR pointer, not a file descriptor.
> If the directory was properly opened, one would never attempt to
> fsync() it.

It's the libc which defines it. Theere no syscall "opendir". How you think
you can return what sus defines as "DIR*" from the kernel?

offtopic: on aix you can do this: "cat ."

