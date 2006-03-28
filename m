Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWC1KOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWC1KOJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 05:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWC1KOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 05:14:09 -0500
Received: from web37710.mail.mud.yahoo.com ([209.191.87.108]:54908 "HELO
	web37710.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932069AbWC1KOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 05:14:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=eCNJtYNZSd6+fi3Xj1ptuDXT+D83g3U3HwxnSYCKViMs1sOdv54KxpqI+vfWRiJpMvqmbdswGi57jkNU4jO+7dSmHcPjt1gwtQTk2/cr5r3rLomxvfqU2/81y1P1QLkhyYp4JSYb1NGWSokVEfGLnB8/B0/RJwcKYaVp5jbNk60=  ;
Message-ID: <20060328101407.96598.qmail@web37710.mail.mud.yahoo.com>
Date: Tue, 28 Mar 2006 02:14:07 -0800 (PST)
From: Edward Chernenko <edwardspec@yahoo.com>
Subject: Re: [PATCH 2.6.15] Adding kernel-level identd dispatcher
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, edwardspec@gmail.com
In-Reply-To: <1143482216.28645.15.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Trond Myklebust <trond.myklebust@fys.uio.no>
wrote:
>
> Justification, please.
> 
> You haven't even tried to explain to us what is so
> broken about the
> userland identd that it needs to be replaced with a
> kernel version.
> 

My point is that everything which follows this
conditions should be moved into kernel:
 - must dispatch requests in a fixed time
 - must work rarely, sleep most time
 - must depend on internal kernel variables (for
example, established connections table)

Don't forget that many years ago there was echo daemon
in userspace. But as it's highly effective to dispatch
all echo requests in kernel, it was moved into
low-level TCP implementation. 

I think that ident protocol also matches this
criteria.

Edward Chernenko <edwardspec@gmail.com>

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
