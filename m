Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317988AbSGLVDf>; Fri, 12 Jul 2002 17:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317995AbSGLVDe>; Fri, 12 Jul 2002 17:03:34 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:49658 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317988AbSGLVDd>; Fri, 12 Jul 2002 17:03:33 -0400
Subject: Re: MAP_NORESERVE with MAP_SHARED
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200207122039.g6CKdnV3004060@napali.hpl.hp.com>
References: <200207122039.g6CKdnV3004060@napali.hpl.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Jul 2002 23:15:02 +0100
Message-Id: <1026512102.9915.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-12 at 21:39, David Mosberger wrote:
> Is there a good reason why the MAP_NORESERVE flag is ignored when
> MAP_SHARED is specified?  (Hint: it's the call to vm_enough_memory()
> in shmem_file_setup() that's causing MAP_NORESERVE to be ignored.)

In no overcommit mode MAP_NORESERVE is never honoured. In conventional
overcommit mode I may have broken something between base and -ac. Which
bit of the code are you looking at ?

