Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752208AbWJ0OZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbWJ0OZH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 10:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbWJ0OZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 10:25:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18396 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752210AbWJ0OZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 10:25:04 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Arjan van de Ven <arjan@infradead.org>
To: Gianluca Alberici <gianluca@abinetworks.biz>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4540E1BB.1000101@abinetworks.biz>
References: <1161807069.3441.33.camel@dv>
	 <1161808227.7615.0.camel@localhost.localdomain>
	 <20061025205923.828c620d.akpm@osdl.org>
	 <1161859199.12781.7.camel@localhost.localdomain>
	 <20061026090002.49b04f1b@freekitty>  <4540E1BB.1000101@abinetworks.biz>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 27 Oct 2006 16:24:58 +0200
Message-Id: <1161959098.12281.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> i've found:
> 
> __create_workqueue
> queue_work


if you change the queue_work() calls to schedule_work() (and drop it's
first argument) and just remove the create_workqueue() entirely, does it
work then? (probably also need to remove destroy_workqueue() call)
if so, that's the real solution on the ndiswrapper side...


