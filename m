Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWGFXiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWGFXiG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWGFXiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:38:05 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:46551 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751054AbWGFXiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:38:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=kf7/9QQjYiVd6gtz7Xf/7Ui1BtimJ0YESUwpIVUaVfDDS3V5l2yF1gN1oSVww55l7/OmRaQc1djJz/bzUn0otxb2TsMWBiFkz1oy9BWfjPGSM7FuDmetCYMXHkEQGp+s4J3bhI1CmNk52D2nxbHE2cTX1TZ3DXCbnE9wObyAFgw=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'David Chinner'" <dgc@sgi.com>, "'Adrian Bunk'" <bunk@stusta.de>
Cc: <xfs-masters@oss.sgi.com>, <xfs@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: fs/xfs/xfs_vnodeops.c:xfs_readdir(): NULL variable dereferenced
Date: Thu, 6 Jul 2006 16:37:59 -0700
Message-ID: <00c201c6a155$38c255f0$493d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20060706233246.GB15160733@melbourne.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcahVNRubWi/afgCTO6VGw+OjnLzTAAACwtg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > <--  snip  -->
> > 
> > Note that tp is never assigned any value other than NULL (and the 
> > Coverity checker found a way how tp might be dereferenced four 
> > function calls later).
> 
> Then the bug is probably in the function call that uses tp 
> without first checking whether it's null. Can you tell us 
> where that dereference occurs?
> 
> Cheers,
> 
> Dave.

Maybe, but the above code is confusing too.

Why not get rid of tp and explicitly pass NULL as "xfs_dir_getdents(NULL, dp, uiop, eofp);"?

Hua

