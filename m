Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVGVPvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVGVPvh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 11:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVGVPvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 11:51:37 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:7139 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261300AbVGVPvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 11:51:37 -0400
Subject: Re: Linux tty layer hackery: Heads up and RFC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050722145716.GA3332@bitwizard.nl>
References: <1121967993.19424.18.camel@localhost.localdomain>
	 <20050722145716.GA3332@bitwizard.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 22 Jul 2005 17:16:08 +0100
Message-Id: <1122048968.9478.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-07-22 at 16:57 +0200, Rogier Wolff wrote:
> Ok, So then I start copying characters into the flipstring, but how do
> I say I'm done?

tty_flip_buffer_push() (or its possibly renamed equivalent). At that
point as now the buffer may get processed or queued to the ldisc. At
that point its now owned by the ldisc and the tty buffer layer will give
you new buffers.


