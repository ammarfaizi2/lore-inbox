Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270349AbRHSLH0>; Sun, 19 Aug 2001 07:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270347AbRHSLHQ>; Sun, 19 Aug 2001 07:07:16 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:63748 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S270343AbRHSLHC>; Sun, 19 Aug 2001 07:07:02 -0400
From: Kernel Mailing List <kernel@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200108191107.f7JB79o09424@wildsau.idv-edu.uni-linz.ac.at>
Subject: Re: Can't compile ntfs modules with 2.4.9
In-Reply-To: <3B7F9D0A.3070805@rz.uni-potsdam.de> from Juergen Rose at "Aug 19, 1 01:03:38 pm"
To: rose@rz.uni-potsdam.de (Juergen Rose)
Date: Sun, 19 Aug 2001 13:07:09 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> unistr.c: In function `ntfs_collate_names':
> unistr.c:99: warning: implicit declaration of function `min'

edit unistr.c, go to line 98. insert the following lines:

#undef min
#define min(a,b) (a<b?a:b)


