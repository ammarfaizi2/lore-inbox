Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266871AbUIORGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266871AbUIORGl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUIOREi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:04:38 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:39178 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S266646AbUIORAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:00:19 -0400
Date: Wed, 15 Sep 2004 17:59:33 +0100
From: Dave Jones <davej@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Ricky Beam <jfbeam@bluetronic.net>,
       Zilvinas Valinskas <zilvinas@gemtek.lt>,
       Erik Tews <erik@debian.franken.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 rc2 freezing
Message-ID: <20040915165933.GD24892@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lee Revell <rlrevell@joe-job.com>, Jeff Garzik <jgarzik@pobox.com>,
	Ricky Beam <jfbeam@bluetronic.net>,
	Zilvinas Valinskas <zilvinas@gemtek.lt>,
	Erik Tews <erik@debian.franken.de>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.33.0409151047560.10693-100000@sweetums.bluetronic.net> <1095263296.2406.141.camel@krustophenia.net> <41486691.3080202@pobox.com> <1095264408.2406.148.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095264408.2406.148.camel@krustophenia.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 12:06:48PM -0400, Lee Revell wrote:

 > Anyway, if you are running anything on your server that breaks under
 > PREEMPT, it will break anyway as soon as you add another processor.

Wrong. Code can be SMP safe but not preempt safe.
This is why we have get_cpu()/put_cpu(), and
preempt_disable()/preempt_enable() pairs around certain parts of code.

Anything using per-CPU data like MSRs for example needs explicit
protection against preemption.

		Dave

