Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWDYUOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWDYUOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWDYUOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:14:51 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:60408 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751427AbWDYUOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:14:51 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 11/13] s390: instruction processing damage handling.
Date: Tue, 25 Apr 2006 22:14:38 +0200
User-Agent: KMail/1.9.1
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       heiko.carstens@de.ibm.com
References: <20060424150544.GL15613@skybase> <20060424165823.0065c826.akpm@osdl.org>
In-Reply-To: <20060424165823.0065c826.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604252214.38662.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tuesday 25 April 2006 01:58 schrieb Andrew Morton:
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> > +			tmp = get_clock();
>
> s390 has a get_clock()?  I guess you don't use i2c much.
>
> We shouldn't use such generic-looking identifiers for arch-specific things.
>  But I guess you can defer the great renaming to s390_get_clock() until
> something actually breaks.

Many places could probably just use get_cycles() if they don't need
sub-cycle resolution. Also such an update could be combined with
a move to the new store-clock-fast instruction.

	Arnd <><
