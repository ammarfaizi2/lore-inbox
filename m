Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266229AbUFPKA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266229AbUFPKA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 06:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUFPKA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 06:00:27 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:61639 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S266229AbUFPKAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 06:00:17 -0400
Date: Wed, 16 Jun 2004 12:00:08 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Florian Schirmer <jolt@tuxbox.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm <akpm@osdl.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [STACK] >3k call path in ide
Message-ID: <20040616100008.GB2548@wohnheim.fh-wedel.de>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de> <20040615163445.6b886383.rddunlap@osdl.org> <200406160911.11985.jolt@tuxbox.org> <20040616094737.GA2548@wohnheim.fh-wedel.de> <40D01928.1080309@tuxbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40D01928.1080309@tuxbox.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 June 2004 11:55:52 +0200, Florian Schirmer wrote:
> 
> >Leak memory.
> 
> Nope. It will deadlock just like the original patch because failed falls 
> through to err_kfree which then will jump to failed...

Both, leak memory on good path, deadlock on error path.  Fun patch. :)

Jörn

-- 
It is better to die of hunger having lived without grief and fear,
than to live with a troubled spirit amid abundance.
-- Epictetus
