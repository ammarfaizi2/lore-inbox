Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317239AbSFCAEn>; Sun, 2 Jun 2002 20:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317240AbSFCAEm>; Sun, 2 Jun 2002 20:04:42 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:51197 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317239AbSFCAEl>; Sun, 2 Jun 2002 20:04:41 -0400
Subject: Re: make memclass() an inline functino
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
In-Reply-To: <20020602233336.GC14918@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Jun 2002 02:09:21 +0100
Message-Id: <1023066561.23878.54.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-03 at 00:33, William Lee Irwin III wrote:
> memclass is too large to be a #define; it overflows 80 columns and does
> not make use of facilities available only to macros.
> 
> This patch convert memclass() to be an inline function.

Exercise care when doing this. Gcc sometimes optimises macros better
than it optimises inline functions

