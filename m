Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbUJaCZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUJaCZx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 22:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbUJaCZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 22:25:53 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:45509 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261472AbUJaCZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 22:25:50 -0400
Date: Sat, 30 Oct 2004 19:25:37 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add panic blinking to 2.6
Message-ID: <20041031022537.GB18294@taniwha.stupidest.org>
References: <20041031013649.GF19396@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031013649.GF19396@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 02:36:49AM +0100, Andi Kleen wrote:

> This patch readds the panic blinking that was in 2.4
> to 2.6.

cool

> +static int blink_frequency = 500;
> +module_param_named(panicblink, blink_frequency, int, 0600);

does it reall need to be a module? 

> +/* Returns how long it waited in ms */
> +long (*panic_blink)(long time) = no_blink;
> +EXPORT_SYMBOL(panic_blink);

i dont know we can't have this unconditionally with the 500ms period
(always present and on)

would that really harm anything?
