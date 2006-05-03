Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWECA0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWECA0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 20:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWECA0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 20:26:07 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:33657 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751330AbWECA0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 20:26:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=bWtgthkML/61flPXhFGFCl3JW/xiwK+AcOKkHAvK18jHpiA4Xp7XhZe6ne48aVHvA584l29zCT4xkUHN30PanM8k3yGPUV128pNsaXLKVAyBw8Qi8eshWGREAXVMr3S7NS2+vyqkXoltdSoNeM2m1i5JT9kQrDFfUvTpa0Gr4BY=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 00/14] remap_file_pages protection support
Date: Wed, 3 May 2006 02:25:49 +0200
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>,
       Ulrich Drepper <drepper@redhat.com>, Val Henson <val.henson@intel.com>
References: <20060430172953.409399000@zion.home.lan> <4456D5ED.2040202@yahoo.com.au>
In-Reply-To: <4456D5ED.2040202@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605030225.54598.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 05:45, Nick Piggin wrote:
> blaisorblade@yahoo.it wrote:
> > This will be useful since the VMA lookup at fault time can be a
> > bottleneck for some programs (I've received a report about this from
> > Ulrich Drepper and I've been told that also Val Henson from Intel is
> > interested about this). I guess that since we use RB-trees, the slowness
> > is also due to the poor cache locality of RB-trees (since RB nodes are
> > within VMAs but aren't accessed together with their content), compared
> > for instance with radix trees where the lookup has high cache locality
> > (but they have however space usage problems, possibly bigger, on 64-bit
> > machines).

> Let's try get back to the good old days when people actually reported
> their bugs (togther will *real* numbers) to the mailing lists. That way,
> everybody gets to think about and discuss the problem.

I've not seen the numbers indeed, I've been told of a problem with a "customer 
program" and Ingo connected my work with this problem. Frankly, I've been 
always astonished about how looking up a 10-level tree can be slow. Poor 
cache locality is the only thing that I could think about.

That said, it was an add-on, not the original motivation of the work.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
