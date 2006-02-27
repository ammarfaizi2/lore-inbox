Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbWB0JSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWB0JSx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 04:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbWB0JSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 04:18:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52898 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751710AbWB0JSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 04:18:52 -0500
Subject: Re: [Patch 5/7]  synchronous block I/O delays
From: Arjan van de Ven <arjan@infradead.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <4402C2AF.2030008@watson.ibm.com>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141028448.5785.64.camel@elinux04.optonline.net>
	 <1141028957.2992.61.camel@laptopd505.fenrus.org>
	 <4402C2AF.2030008@watson.ibm.com>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 10:18:50 +0100
Message-Id: <1141031931.2992.78.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 04:13 -0500, Shailabh Nagar wrote:
> Arjan van de Ven wrote:
> 
> >>+static inline void delayacct_blkio(void)
> >>+{
> >>+	if (unlikely(current->delays && delayacct_on))
> >>+		__delayacct_blkio();
> >>+}
> >>    
> >>
> >
> >why is this unlikely?
> >  
> >
> delayacct_on is expected to be off most of the time,

that's not really enough I think to warrent a compiler hint

>  hence the compound is
> unlikely too.

you then should move that as first in the test instead ;-)



