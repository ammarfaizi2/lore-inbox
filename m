Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWGQTCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWGQTCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 15:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWGQTCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 15:02:39 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:51164
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751153AbWGQTCi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 15:02:38 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: kernel/timer.c: next_timer_interrupt() strange/buggy(?) code (2.6.18-rc1-mm2)
Date: Mon, 17 Jul 2006 21:01:42 +0200
User-Agent: KMail/1.9.1
References: <20060717185330.GA32264@rhlx01.fht-esslingen.de>
In-Reply-To: <20060717185330.GA32264@rhlx01.fht-esslingen.de>
Cc: keir@xensource.com, Tony Lindgren <tony@atomide.com>, zach@vmware.com,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607172101.43252.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 July 2006 20:53, Andreas Mohr wrote:
> (a "continue" simply continue:s the loop without checking the loop condition
> at the bottom, right?)

I don't think so. Test it. This is no infinite loop:

int main(void)
{
        int i = 0;
        do {
                i++;
                continue;
        } while (i < 1000);
}

-- 
Greetings Michael.
