Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSE0Nao>; Mon, 27 May 2002 09:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316611AbSE0Nai>; Mon, 27 May 2002 09:30:38 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:1021 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316609AbSE0Nag>; Mon, 27 May 2002 09:30:36 -0400
Subject: Re: [PATCH,CFT] Tentative fix for mem. corruption caused by intel
	815 AGP
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Cc: Alessandro Morelli <alex@alphac.it>, stilgar2k@wanadoo.fr,
        linux-kernel@vger.kernel.org
In-Reply-To: <3CF2144C.709@epfl.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 15:33:01 +0100
Message-Id: <1022509981.11859.284.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 12:11, Nicolas Aspert wrote:
> Just another quick thought... in all intel chipsets datasheets, the bits 
> 0-11 of the ATTBASE register are also marked as 'reserved'. So far, all 
> the intel_*_configure routines are writing shamelessly on these bits. 
> Shouldn't we mask those bits out too (though it seems this has not 
> caused any trouble so far) ?

We ought to mask and copy the original yes. The number of times we've
had Linux driver breakages by not masking and avoiding writes to
reserved bits is small but it does happen occasionally.

Alan

