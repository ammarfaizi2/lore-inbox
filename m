Return-Path: <linux-kernel-owner+willy=40w.ods.org-S382379AbUKAXjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S382379AbUKAXjt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268374AbUKAXbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:31:48 -0500
Received: from deliver.epitech.net ([163.5.0.25]:50992 "HELO
	ideliver.epitech.net") by vger.kernel.org with SMTP id S380292AbUKAXBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 18:01:08 -0500
Date: Tue, 2 Nov 2004 00:01:03 +0100
From: Marc Bevand <bevand_m@epita.fr>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [rc4-amd64] RC4 optimized for AMD64
Message-ID: <20041101230103.GA656@iah.epita.fr>
References: <cm4moc$c7t$1@sea.gmane.org> <Pine.LNX.4.61.0411011233203.8483@twinlark.arctic.org> <Pine.LNX.4.61.0411011249550.25856@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411011249550.25856@twinlark.arctic.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
| 
| [...]
| ack... it's too early on a monday morning -- i misread the documentation.
| this ZF assumption is actually defined and portable... still kind of ugly.
| how much benefit do you see?

When "dec" is placed before "ror", throughput goes up by about 5%
on my test system (Opteron 244 rev C0). I don't find it "ugly"
because the optimization no intrusive at all (only 1 moved instruction).

Concerning the "dec / sub $1" case, it makes absolutely no difference
on the Opteron, I just used "dec" because the opcode is 3 bytes length
instead of 4.

-- 
Marc Bevand                          http://www.epita.fr/~bevand_m
Computer Science School EPITA - System, Network and Security Dept.
