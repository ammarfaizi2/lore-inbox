Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTDSRHA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 13:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTDSRG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 13:06:59 -0400
Received: from gw.enyo.de ([212.9.189.178]:15122 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S263424AbTDSRG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 13:06:58 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
References: <20030419180421.0f59e75b.skraw@ithnet.com>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sat, 19 Apr 2003 19:18:56 +0200
In-Reply-To: <20030419161011$0136@gated-at.bofh.it> (Stephan von
 Krawczynski's message of "Sat, 19 Apr 2003 18:10:11 +0200")
Message-ID: <87lly6flrz.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090017 (Oort Gnus v0.17) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski <skraw@ithnet.com> writes:

> Most I came across have only small problems (few dead sectors),

IDE disks automatically remap defective sectors, so you won't see any
of them unless the disk is already quite broken.

Some disks (notably the IBM DTLA series) cannot deal with sudden power
failures during write operators.  In such a case, the sector has an
incorrect checksum and cannot be read until after the next write.
