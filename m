Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267166AbTGHLO1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 07:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbTGHLOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 07:14:15 -0400
Received: from tmi.comex.ru ([217.10.33.92]:64644 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S267194AbTGHLN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 07:13:57 -0400
X-Comment-To: Andi Kleen
To: Andi Kleen <ak@suse.de>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] parallel directory operations
From: bzzz@tmi.comex.ru
Date: Tue, 08 Jul 2003 15:28:27 +0000
In-Reply-To: <p73brw5qmxk.fsf@oldwotan.suse.de> (Andi Kleen's message of "08
 Jul 2003 13:26:31 +0200")
Message-ID: <87of05ujfo.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <87wuetukpa.fsf@gw.home.net.suse.lists.linux.kernel>
	<p73brw5qmxk.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andi Kleen (AK) writes:

 AK> Alex Tomas <bzzz@tmi.comex.ru> writes:
 >> dynamic locks. supports exclusive and shared locks. exclusive lock may
 >> be taken several times by first owner.

 AK> What's the difference between these locks and the existing rw semaphores?

dynlocks implements 'lock namespace', so you can lock A for namepace N1 and
lock B for namespace N1 and so on. we need this because we want to take lock
on _part_ of directory.

