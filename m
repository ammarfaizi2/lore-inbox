Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbULOKuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbULOKuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 05:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbULOKuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 05:50:12 -0500
Received: from gw.goop.org ([64.81.55.164]:54168 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S262318AbULOKuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 05:50:08 -0500
Subject: Re: 32-bit syscalls from 64-bit process on x86-64?
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andi Kleen <ak@suse.de>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041215042704.GE27225@wotan.suse.de>
References: <380350F3EC1@vcnet.vc.cvut.cz>
	 <20041215042704.GE27225@wotan.suse.de>
Content-Type: text/plain
Date: Wed, 15 Dec 2004 02:50:07 -0800
Message-Id: <1103107807.24540.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-0.mozer.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 05:27 +0100, Andi Kleen wrote:
> From 64bit-from-32bit the lcall is needed agreed. However as a 
> warning it will not work for all calls since a few check a bit
> in task_struct that says if the process is 32bit or 64bit
> (rather rare though, most prominent is signal handling) 

When delivering a signal to a 64-bit process (ie, without TIF_IA32 set),
do you think it should always set cs to be USER_CS?  At the moment, if
cs is something else (ie, USER32_CS), it tries to deliver the signal
with that current...

	J

