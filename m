Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267371AbRGKRco>; Wed, 11 Jul 2001 13:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267374AbRGKRce>; Wed, 11 Jul 2001 13:32:34 -0400
Received: from www.wen-online.de ([212.223.88.39]:30222 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S267371AbRGKRc0>;
	Wed, 11 Jul 2001 13:32:26 -0400
Date: Wed, 11 Jul 2001 19:31:38 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Ho Chak Hung <hunghochak@netscape.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages 4 order allocation failed
In-Reply-To: <448CBB1C.4314B00D.0F76C228@netscape.net>
Message-ID: <Pine.LNX.4.33.0107111925250.371-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2001, Ho Chak Hung wrote:

> Hi,
> but there isn't any call in the module to allocate 4 order pages. There are only calls to allocate 0 order pages. alloc_pages(GFP_KERNEL, 0)is the only call to allocate page in the whole module.

Then it's not your module :)

Some driver may be asking for order 4, but settling for less when
that fails.

	-Mike

