Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266781AbUF3RzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266781AbUF3RzW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266796AbUF3RzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:55:22 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:36852 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266790AbUF3Ryb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:54:31 -0400
Date: Wed, 30 Jun 2004 12:53:51 -0500
From: linas@austin.ibm.com
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64: (resend) Janitor signature of rtas_call() routine
Message-ID: <20040630125351.U21634@forte.austin.ibm.com>
References: <20040629154202.N21634@forte.austin.ibm.com> <16610.42236.698377.733729@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16610.42236.698377.733729@cargo.ozlabs.ibm.com>; from paulus@samba.org on Wed, Jun 30, 2004 at 09:33:16PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 09:33:16PM +1000, Paul Mackerras wrote:
> Linas,
> 
> > Can you please apply the following patch to the ameslab ppc64
> > tree, and/or roll it upwards to the marclello 2.6 tree?
> > This path is 100% pure cleanup; no functional changes.
> > 
> > I got irritated when I was given a -1 that was cast to an unsigned
> > int that was then cast to a signed (64-bit) long, and so I received
> > a value of 4 billion instead of -1.  This patch fixes this insanity.
> > 
> > Different files were treating this return code as being signed
> > or unsigned, 32-bit or 64-bit.  The 'real' return code is always
> > a signed 32-bit quantity, so this patch just makes the usage
> > consistent across the board.
> 
> I beat you to the punch on this one, I'm afraid. :)  I changed
> rtas_call to return an int in the prom cleanup patch I sent to Andrew
> last week.  You did spot a few places that I missed though, so I'll
> send Andrew a patch to fix those up shortly.

Well, your patch is not in the ameslab tree :( at least as of friday 
night.  I'm working off of ameslab, is there a different tree I should
follow at this time?

--linas
