Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262346AbTCPE60>; Sat, 15 Mar 2003 23:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262372AbTCPE60>; Sat, 15 Mar 2003 23:58:26 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:37893 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S262346AbTCPE6Z>; Sat, 15 Mar 2003 23:58:25 -0500
Subject: Re: [patch] NUMAQ subarchification
From: James Bottomley <James.Bottomley@steeleye.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303152036250.27065-100000@chaos.physics.uiowa.edu>
References: <Pine.LNX.4.44.0303152036250.27065-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 15 Mar 2003 23:05:55 -0600
Message-Id: <1047791157.1963.212.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-15 at 20:53, Kai Germaschewski wrote:
> I think VPATH has never been meant to be used for anything like this, it 
> could be make to work, though it would interfere with the separate src/obj 
> thing. But I don't think it's a good idea, we'll have object files 
> magically appear without any visible source file, that's just too obscure.

Well...There is a slightly different solution.

What if the summit/numaq setup.c simply contained 

#include "../mach-default/setup.c"

?

Not that I like doing this, but it solves the "magic" appearace of the
object file and it's perfectly clear to anyone editing the file where it
really comes from.

James


