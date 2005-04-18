Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVDRElX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVDRElX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 00:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVDRElX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 00:41:23 -0400
Received: from nevyn.them.org ([66.93.172.17]:53389 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261653AbVDRElU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 00:41:20 -0400
Date: Mon, 18 Apr 2005 00:41:16 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 & x86_64: Live Patching Funcion on 2.6.11.7
Message-ID: <20050418044115.GA15002@nevyn.them.org>
Mail-Followup-To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <4261DC62.1070300@lab.ntt.co.jp> <20050416234439.5464e188.davem@davemloft.net> <20050417185143.GA5002@nevyn.them.org> <20050417133252.353a5666.davem@davemloft.net> <42631043.7000409@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42631043.7000409@lab.ntt.co.jp>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 10:41:23AM +0900, Takashi Ikebe wrote:
> Daniel-san,
> GDB based approach seems not fit to our requirements. GDB(ptrace) based 
> functions are basically need to be done when target process is stopping. 
> From our experience, sometimes patches became to dozens to hundreds at 
> one patching, and in this case GDB based approach cause target process's 
> availability descent.

That's right, it does require the target process be stopped.  If it
isn't stopped how do you know it isn't executing the same instruction
you're currently patching?

Even with hundreds of kilobytes of patch, I have trouble imagining this
takes a substantial amount of time.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
