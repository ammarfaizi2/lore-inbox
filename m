Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310438AbSCALMd>; Fri, 1 Mar 2002 06:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293510AbSCALKg>; Fri, 1 Mar 2002 06:10:36 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:28691 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S310436AbSCALIZ>; Fri, 1 Mar 2002 06:08:25 -0500
Date: Fri, 1 Mar 2002 12:08:19 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: rsync kills 2.4.1X, also -ac and 2.4.18-rc4+XFS.
Message-ID: <20020301110819.GD8222@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020301043615.GA1668@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020301043615.GA1668@merlin.emma.line.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Mar 2002, Matthias Andree wrote:

> I "killed" my kernel (it was just swapping and otherwise irresponsive)
> with just aborting rsync v2.5.2.

My followup didn't make it, so here's a quick resend:

in that rsync version, after ^C, not all threads are killed, and the
remaining one wreaks havoc and eats all memory. NOT A KERNEL PROBLEM,
please apologize. (Running ulimit -v 30000 before or softlimit on rsync
cures this, obviously, to prevent the remaining runaway thread from
eating all memory.)
