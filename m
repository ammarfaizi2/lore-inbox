Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264024AbTEWLOw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 07:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbTEWLOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 07:14:52 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:51339 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S264024AbTEWLOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 07:14:51 -0400
Date: Fri, 23 May 2003 13:17:57 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][2.5] generic_usercopy() function (resend, forgot the patches)
Message-ID: <20030523131757.K626@nightmaster.csn.tu-chemnitz.de>
References: <3ECDEBC5.5030608@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3ECDEBC5.5030608@convergence.de>; from hunold@convergence.de on Fri, May 23, 2003 at 11:37:09AM +0200
X-Spam-Score: -4.5 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19JAiK-000427-00*ioYdTpBXfes*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, May 23, 2003 at 11:37:09AM +0200, Michael Hunold wrote:
> In order to prevent this code duplication, introducing a
> generic_usercopy() function to lib/ is one possibilty.

I like the idea, because whoever invented the IOCTL generation
macros forgot exactly this function.

This raised the problem, that some IOCTLs have the wrong numbers
due to the author not being able to grok the macros and/or
documentation.

Also many authors have problems evaluating their IOCTLs and get
directions wrong.

So this code helps these issues. 

I just miss variants for the smaller sizes. These should be
handled differently and more easily, 
so better warn about sizes <= sizeof(void *).

Regards

Ingo Oeser
