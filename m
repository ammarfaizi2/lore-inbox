Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293205AbSCOTbz>; Fri, 15 Mar 2002 14:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293204AbSCOTbq>; Fri, 15 Mar 2002 14:31:46 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:5897 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S293201AbSCOTbc>; Fri, 15 Mar 2002 14:31:32 -0500
Message-Id: <200203151931.g2FJVMI79884@aslan.scsiguy.com>
To: Len Sorensen <lsorense@opengraphics.com>
cc: Richard Harman <rharman@xabean.net>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx driver v6.2.4 "queue abort message" questions 
In-Reply-To: Your message of "Fri, 15 Mar 2002 14:02:39 EST."
             <20020315140239.A22884@opengraphics.com> 
Date: Fri, 15 Mar 2002 12:31:22 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I just tried applying the aic7xxx 6.2.5 driver patch to replace 6.2.4
>that is in 2.4.18, and it actually appears to have removed the problem.

This was a known issue that was corrected in 6.2.5.  The driver was
referencing an uninitialized register on the card, which cause the
parity error.  The uninitialized reference was harmless as the value
was ignored in the cases that it was uninitialized, but the panic it
created was a bit rough on users. 8-)

--
Justin
