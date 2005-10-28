Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751802AbVJ1VGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbVJ1VGg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVJ1VGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:06:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:58282 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751802AbVJ1VGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:06:35 -0400
To: Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi>
From: Andi Kleen <ak@suse.de>
Date: 28 Oct 2005 23:06:33 +0200
In-Reply-To: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi>
Message-ID: <p73vezhtkpy.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janne M O Heikkinen <jmoheikk@cc.helsinki.fi> writes:

> With CONFIG_K8_NUMA I get the following right after boot:
> 
> PANIC: early exception rip ffffffff8023429f error 0 cr2 0
> PANIC: early exception rip ffffffff8011893a error 0 cr2 ffffffffff5fd023
> 
> Looking at the System.map 8023429f seems to be find_first_bit
> and 80118993a safe_smp_processor_id. When I compile kernel without
> K8 NUMA it boots fine but eg. ATI Radeon driver doesn work.
> 
> Board I'm using is Tyan S2885 with two Opteron 246's and 4GB ram.

Did earlier kernels work? Please post full log with earlyprintk=vga
or earlyprintk=serial,ttySx,baud

-Andi
