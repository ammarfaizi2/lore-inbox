Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVAMTqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVAMTqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVAMToG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:44:06 -0500
Received: from one.firstfloor.org ([213.235.205.2]:58563 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261402AbVAMTkr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:40:47 -0500
To: Raphael Jacquot <raphael.jacquot@imag.fr>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Subject: Re: NUMA or not on dual Opteron
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
	<200501121824.44327.rathamahata@ehouse.ru>
	<Pine.LNX.4.58.0501120730490.2373@ppc970.osdl.org>
	<20050113094537.GB2547@favonius> <41E6472B.5020701@imag.fr>
From: Andi Kleen <ak@muc.de>
Date: Thu, 13 Jan 2005 20:40:46 +0100
In-Reply-To: <41E6472B.5020701@imag.fr> (Raphael Jacquot's message of "Thu,
 13 Jan 2005 11:02:19 +0100")
Message-ID: <m1oeft2k3l.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raphael Jacquot <raphael.jacquot@imag.fr> writes:
>
> Numa needs to be enabled on bi-opteron systems because each processor
> controls part of the memory. unlike the intel memory architecture,
> where processors share the same bus to access memory.
> Numa in opteron systems is thus required to allow sharing of memory .

[just for the record to avoid wrong information in the archives]

No, that's wrong. Opteron is CC (cache coherent)/NUMA, like most
modern NUMA systems. CC/NUMA tends to be fully transparent, this
means the system can be run like a SMP. Just it's faster to be
NUMA aware.

-Andi
