Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262478AbTC0MQx>; Thu, 27 Mar 2003 07:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262509AbTC0MQx>; Thu, 27 Mar 2003 07:16:53 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:23051 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262478AbTC0MQu>; Thu, 27 Mar 2003 07:16:50 -0500
Date: Thu, 27 Mar 2003 12:28:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 update (1/9): s390 arch fixes.
Message-ID: <20030327122802.A32040@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Arnd Bergmann <arnd@bergmann-dalldorf.de>,
	linux-kernel@vger.kernel.org
References: <OF54A02ABC.0017054F-ONC1256CF6.004232A4@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF54A02ABC.0017054F-ONC1256CF6.004232A4@de.ibm.com>; from schwidefsky@de.ibm.com on Thu, Mar 27, 2003 at 01:17:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 01:17:14PM +0100, Martin Schwidefsky wrote:
> 
> > Now actually take a look at this diff :)  The biggest part is that the
> > s390 compat files exist only on s390x and the math-emu dir only exists
> > on s390, that's just a matter of conditionally compiling the files.
> 
> I did look at the diff. Did you?

Yes.

> The patch is 5600 lines. A
> small part of this diff can probably be avoided but you end up with
> 3000-4000 lines of real diff. Because of the size of this a merge of
> s390 and s390x isn't simple and shouldn't be done in a hurry.

My guess is that the difference can be a lot smaller if abstracted
out properly, but that's pretty mood unless someone actually tries it :)

So yes, it's certainly not trivial (otherwise someone would have
already done it), and I didn't say you should hurry to do it.  Also
note that you don't have to do it all at once, start with #including
the s390 files on s390x that are exactly the same, and after that
one file after another can be cleaned up to be s390/s390x clean.

