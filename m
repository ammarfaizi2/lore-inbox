Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbULMVjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbULMVjS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbULMVjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:39:18 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:14653 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261174AbULMVjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:39:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=M4DxkIrSYTD09JiduKUdvbsj9nlw45mQMTmhJMjWiA0IZKaAh/m0P+SbsIj+40ZR8onUgdxeIo7hQebouSr0TpVrwXJHSpZpQSsx8FM3VtK2lmyLuhCXS0Kra1nzAt2ctNhMk1nE9x03uKTjZNi7lsR7SQQ0rqYZ+ysJEFm485I=
Message-ID: <58cb370e04121313393f00c37c@mail.gmail.com>
Date: Mon, 13 Dec 2004 22:39:02 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] ide-iops: Use platform-dependent port I/O operations
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58L.0412130227420.8571@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58L.0412130227420.8571@blysk.ds.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Dec 2004 02:45:09 +0000 (GMT), Maciej W. Rozycki
<macro@linux-mips.org> wrote:
> Hello,
> 
>  Given the contents of <asm-generic/ide_iops.h> and platform-specific
> peculiarities (like address-dependent hardware byte lane swappers), I

Could you give some specific examples? Thanks.

> believe ide-iops should use __ide_* for port I/O string operations,
> similarly to __ide_mm_* that are already used for memory-mapped I/O ones.
> 
>  Please consider.

This patch looks quite OK but it breaks few archs which don't include
<asm-generic/ide_iops.h> and don't define __ide_[in,out]* macros.

Bartlomiej
