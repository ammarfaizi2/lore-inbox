Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316928AbSGVMpm>; Mon, 22 Jul 2002 08:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316851AbSGVMpm>; Mon, 22 Jul 2002 08:45:42 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:41710 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316928AbSGVMpl>; Mon, 22 Jul 2002 08:45:41 -0400
Subject: Re: [PATCH] strict VM overcommit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>, Adrian Bunk <bunk@fs.tum.de>,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0207221332040.1034-100000@localhost.localdomain>
References: <Pine.LNX.4.21.0207221332040.1034-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 15:01:15 +0100
Message-Id: <1027346475.31787.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 13:45, Hugh Dickins wrote:
> In strict no-overcommit mode, it should probably decide in advance
> whether to embark on swapping off: I think you suggested that
> earlier in the thread, that it's acceptable to switch overcommit
> mode temporarily to achieve whichever behaviour is desirable?

Yes. I have no problem with

	#swapoff -a
	swapoff: out of memory
	#vmctl overcommit 1
	#swapoff -a

