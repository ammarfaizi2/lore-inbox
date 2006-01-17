Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWAQPc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWAQPc5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 10:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWAQPc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 10:32:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26292 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751280AbWAQPc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 10:32:56 -0500
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
From: Arjan van de Ven <arjan@infradead.org>
To: Serge Hallyn <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20060117143326.283450000@sergelap>
References: <20060117143258.150807000@sergelap>
	 <20060117143326.283450000@sergelap>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 16:32:51 +0100
Message-Id: <1137511972.3005.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 08:33 -0600, Serge Hallyn wrote:
> plain text document attachment (BC-define-pid-handlers)
> Actually define the task_pid() and task_tgid() functions.  Also
> replace pid with __pid so as to make sure any missed accessors are
> caught.

This question was asked a few times before without satisfactory answer:
*WHY* this abstraction.
There is *NO* point. Really. 

(And if the answer is "but we want to play tricks later", just make a
current->realpid or whatever, but leave current->pid be the virtual pid.
Your abstraction helps NOTHING there. Zero Nada Noppes).


