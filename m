Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272806AbTGaHix (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 03:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272807AbTGaHix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 03:38:53 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:16322
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272806AbTGaHiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 03:38:51 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O10int for interactivity
Date: Thu, 31 Jul 2003 17:43:17 +1000
User-Agent: KMail/1.5.2
Cc: Johoho <johoho@hojo-net.de>, wodecki@gmx.de, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <200307280112.16043.kernel@kolivas.org> <20030728143545.1d989946.akpm@osdl.org> <3F28B8D5.4040600@cyberone.com.au>
In-Reply-To: <3F28B8D5.4040600@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307311743.17370.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003 16:36, Nick Piggin wrote:
> Oh, and the process scheduler can definitely be a contributing factor.
> Even if it looks like your process is getting enough cpu, if your
> process doesn't get woken in less than 5ms after its read completes,
> then AS will give up waiting for it.

This part interests me. It would seem that either 
1. The AS scheduler should not bother waiting at all if the process is not 
going to wake up in that time
2. The process should be woken in that time to ensure the AS scheduler is not 
wasting it's time waiting.
or a combination of 1 and 2 depending on some heuristic deciding on how 
important it is for 2 instead of 1.

No, I'm not planning on trying to implement either of these <insert usual 
complaint about time and knowledge here>, but I thought I should at least 
contribute my thoughts.

Con

