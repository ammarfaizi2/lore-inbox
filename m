Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWFPTRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWFPTRR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 15:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWFPTRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 15:17:17 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:50326 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750865AbWFPTRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 15:17:16 -0400
Subject: Re: sock_alloc() symbol removed in 2.6.10
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ralf Dauberschmidt <rfk@digitalstyle.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1150473371.3070.0.camel@laptopd505.fenrus.org>
References: <000f01c69133$41114bd0$0200000a@redstorm>
	 <1150473371.3070.0.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 16 Jun 2006 15:20:22 -0400
Message-Id: <1150485622.18071.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-16 at 17:56 +0200, Arjan van de Ven wrote:
> On Fri, 2006-06-16 at 12:54 +0200, Ralf Dauberschmidt wrote:
> > Hello,
> > 
> > As of kernel 2.6.10 the symbol export of the sock_alloc() function has been
> > removed (I assume in the course of "Remove dead socket layer exports"). Can
> > anybody tell me why this happened? Why is it "dead"?
> 
> nobody used it ?

Also, it would be better to use sock_create_lite() to ensure proper
handling by the security subsystem.  See:
http://marc.theaimsgroup.com/?l=git-commits-head&m=108407590404054&w=2

-- 
Stephen Smalley
National Security Agency

