Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbUKCTBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUKCTBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUKCTBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:01:33 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:18831 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S261803AbUKCTB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:01:27 -0500
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, DervishD <lkml@dervishd.net>,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411030751.39578.gene.heskett@verizon.net>
	<200411031147.14179.gene.heskett@verizon.net>
	<20041103174459.GA23015@DervishD>
	<200411031353.39468.gene.heskett@verizon.net>
From: Doug McNaught <doug@mcnaught.org>
Date: Wed, 03 Nov 2004 14:01:20 -0500
In-Reply-To: <200411031353.39468.gene.heskett@verizon.net> (Gene Heskett's
 message of "Wed, 3 Nov 2004 13:53:39 -0500")
Message-ID: <87hdo669kv.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> writes:

> On Wednesday 03 November 2004 12:44, DervishD wrote:

>>    Then the children are reparented to 'init' and 'init' gets rid
>> of them. That's the way UNIX behaves.
>
> Unforch, I've *never* had it work that way.  Any dead process I've 
> ever had while running linux has only been disposable by a reboot.

Then it's either (a) not actually a zombie (perhaps stuck in D state),
or (b) its parent is still alive.

A zombie process is just an entry in the process table where the exit
status etc are stored until the parent reaps it--all other resources
(memory, FDs etc) have been released.  So if your "zombie" process is
actually taking up resources (which I think you said in an earlier
post), there's something else at work.

-Doug
