Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269173AbUHaUmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269173AbUHaUmg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUHaUmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:42:25 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:13018 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269192AbUHaUl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:41:29 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040831203900.GB2356@elte.hu>
References: <20040831070658.GA31117@elte.hu>
	 <1093980065.1603.5.camel@krustophenia.net> <20040831193734.GA29852@elte.hu>
	 <1093981634.1633.2.camel@krustophenia.net> <20040831195107.GA31327@elte.hu>
	 <20040831200912.GA32378@elte.hu>
	 <1093983034.1633.11.camel@krustophenia.net> <20040831201420.GA899@elte.hu>
	 <20040831202051.GA1111@elte.hu> <1093984452.1596.0.camel@krustophenia.net>
	 <20040831203900.GB2356@elte.hu>
Content-Type: text/plain
Message-Id: <1093984886.1596.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 16:41:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 16:39, Ingo Molnar wrote:

> hm, this doesnt seem to be an mtrr latency - this is a text-console 
> blanking operation apparently running with the BKL enabled.
> 

Yes, this seemed strange to me too, but I reproduced this several times,
even across reboots.  This one must have been happening right before the
MTRR initialization, and was getting masked by it.

Lee 

