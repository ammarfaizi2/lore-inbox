Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751530AbVJSFpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbVJSFpu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 01:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbVJSFpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 01:45:49 -0400
Received: from qproxy.gmail.com ([72.14.204.203]:59067 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751532AbVJSFpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 01:45:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=kBNx6+EcmXWhnVqzoOtfROikNPmz55xVbccjlD/viDwDWSZQNhHaDd7cu+IdkaOfPLjN4EujuUsWAqB/qfmAkjMiVwdlxHeBFhWKjRBPAQv4evC43yL/KkuGKxGBYaGC9V52JtrNLnpj+aIsogqLhd9wZBBBGhdCCIhVFd8uIw0=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: large files unnecessary trashing filesystem cache?
Date: Wed, 19 Oct 2005 01:45:45 -0400
User-Agent: KMail/1.8.3
Cc: gfiala@s.netic.de, linux-kernel@vger.kernel.org
References: <200510182201.11241.gfiala@s.netic.de> <200510182302.59604.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20051018213721.236b2107.akpm@osdl.org>
In-Reply-To: <20051018213721.236b2107.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510190145.45911.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 October 2005 00:37, Andrew Morton wrote:
> Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> >
> > Sometimes you want a single file to take up most of the memory; databases
> >  spring to mind. Perhaps files/processes that take up a large proportion of
> >  memory should be penalized by preferentially reclaiming their pages, but
> >  limit the aggressiveness so that they can still take up most of the memory
> >  if sufficiently persistent (and the rest of the system isn't thrashing).
> 
> Yes.  Basically any smart heuristic we apply here will have failure modes. 
> For example, the person whose application does repeated linear reads of the
> first 100MB of a 4G file will get very upset.

As will any dumb heuristic for that matter; we'd need precognition[1] to avoid
all of them. But we can hopefully make the failure modes rarer and more
predictable. I don't know how my proposal would fare, and as I do not have
the code to test the matter I think I shall drop it.

[1] Which could, on occasion, be provided by hinting.
