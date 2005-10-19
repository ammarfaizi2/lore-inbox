Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVJSSyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVJSSyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 14:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVJSSyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 14:54:15 -0400
Received: from mail.s.netic.de ([212.9.160.11]:43530 "EHLO mail.s.netic.de")
	by vger.kernel.org with ESMTP id S1751219AbVJSSyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 14:54:14 -0400
From: Guido Fiala <gfiala@s.netic.de>
To: linux-kernel@vger.kernel.org
Subject: Re: large files unnecessary trashing filesystem cache?
Date: Wed, 19 Oct 2005 20:52:11 +0200
User-Agent: KMail/1.7.2
References: <200510182201.11241.gfiala@s.netic.de> <200510191958.37542.gfiala@s.netic.de> <3370794E-8B47-4342-8383-C2B0F77192B3@mac.com>
In-Reply-To: <3370794E-8B47-4342-8383-C2B0F77192B3@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510192052.11611.gfiala@s.netic.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 October 2005 20:43, Kyle Moffett wrote:
> On Oct 19, 2005, at 13:58:37, Guido Fiala wrote:
> > Kernel could do the best to optimize default performance,
> > applications that consider their own optimal behaviour should do
> > so, all other files are kept under default heuristic policy
> > (adaptable, configurable one)
> >
> > Heuristic can be based on access statistic:
> >
> > streaming/sequential can be guessed by getting exactly 100% cache
> > hit rate (drop behind pages immediately),
>
> What about a grep through my kernel sources or other linear search
> through a large directory tree?  That would get exactly 100% cache
> hit rate which would cause your method to drop the pages immediately,
> meaning that subsequent greps are equally slow.  I have enough memory
> to hold a couple kernel trees and I want my grepping to push OO.org
> out of RAM for a bit while I do my kernel development.

Ok, it seems this was thought to easy, needs some thinking ;-)
Of course i have lots of similar work and dont like to loose the speedup 
either.

What other useful data for the job do we have already in the structs?
