Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVHHG2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVHHG2x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 02:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVHHG2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 02:28:53 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:4042 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1750739AbVHHG2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 02:28:53 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: EXPORT_SYMBOL generates "is deprecated" noise
Date: Mon, 8 Aug 2005 09:28:31 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <251790000.1123438079@[10.10.2.4]> <20050807201541.D22977@flint.arm.linux.org.uk>
In-Reply-To: <20050807201541.D22977@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508080928.31605.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 August 2005 22:15, Russell King wrote:
> On Sun, Aug 07, 2005 at 11:07:59AM -0700, Martin J. Bligh wrote:
> > I'm getting lots of errors like this nowadays:
> > 
> > drivers/serial/8250.c:2651: warning: `register_serial' is deprecated 
> > (declared at drivers/serial/8250.c:2607)
> > 
> > Which is just: "EXPORT_SYMBOL(register_serial);"
> > 
> > Sorry, but that's just compile-time noise, not anything useful.
> > Warning on real usages of it might be handy (we can go fix the users)
> > but not EXPORT_SYMBOL - we can't kill the export until the function
> > goes away. The more noise we have, the harder it is to see real errors 
> > and warnings.
> 
> I don't know why I bother with __deprecated - I haven't seen much
> evidence of the users of these functions being cleaned up, so I
> think we might as well just delete the functions and _force_ people
> to fix their code.  That unfortunately seems to be the only way to
> get things done in this day and age, which is rather sad if that's
> what it takes to kick people into action.

Was it ever different?
--
vda

