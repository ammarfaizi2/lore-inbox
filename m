Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWDRJXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWDRJXx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 05:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWDRJXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 05:23:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44517 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750719AbWDRJXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 05:23:52 -0400
Subject: Re: Question on Schedule and Preemption
From: Arjan van de Ven <arjan@infradead.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Liu haixiang <liu.haixiang@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060418091724.GA7258@rhlx01.fht-esslingen.de>
References: <bf3792800604180023r2a2111b4ude5ef15f9dd855a@mail.gmail.com>
	 <20060418091724.GA7258@rhlx01.fht-esslingen.de>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 11:23:47 +0200
Message-Id: <1145352228.2976.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If the current task is running and thus not yet exiting (!current->exit_state)
> and is also in an atomic code section (i.e. under lock), it shouldn't call
> any reschedule function (which also happens by just calling msleep(): use
> mdelay() instead in that case!).
> 

actually don't use mdelay, but change your code so that you CAN sleep :)


