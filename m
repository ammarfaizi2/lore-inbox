Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbVHPINk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbVHPINk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 04:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbVHPINj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 04:13:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:14218 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S965138AbVHPINj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 04:13:39 -0400
Date: Tue, 16 Aug 2005 10:14:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050816081413.GB16498@elte.hu>
References: <42FB41B5.98314BA5@tv-sign.ru> <20050812015607.GR1300@us.ibm.com> <42FC6305.E7A00C0A@tv-sign.ru> <20050815174403.GE1562@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815174403.GE1562@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> OK, the attached instead revalidates that the task struct still 
> references the sighand_struct after obtaining the lock (and passes 
> kernbench and LTP, which tells me I need to get better tests!).

i've applied this to the -RT tree, and it's looking good so far from a 
basic stability POV.

	Ingo
