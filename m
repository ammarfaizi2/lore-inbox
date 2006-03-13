Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWCMU2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWCMU2J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbWCMU2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:28:08 -0500
Received: from kanga.kvack.org ([66.96.29.28]:4323 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751886AbWCMU2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:28:04 -0500
Date: Mon, 13 Mar 2006 15:22:42 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, netdev@vger.kernel.org
Subject: Re: [PATCH] scm: fold __scm_send() into scm_send()
Message-ID: <20060313202242.GC27761@kvack.org>
References: <200603130139.k2D1dpSQ021279@shell0.pdx.osdl.net> <20060312.180802.13404061.davem@davemloft.net> <200603132105.32794.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603132105.32794.ioe-lkml@rameria.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 09:05:31PM +0100, Ingo Oeser wrote:
> From: Ingo Oeser <ioe-lkml@rameria.de>
> 
> Fold __scm_send() into scm_send() and remove that interface completly
> from the kernel.

Whoa, what are you doing here?  Uninlining scm_send() is a Bad Thing to do 
given that scm_send() is in the AF_UNIX hot path.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
