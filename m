Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVAQXdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVAQXdN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 18:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVAQXaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 18:30:03 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:55958
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262775AbVAQX0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 18:26:10 -0500
Subject: Re: 2.6.11-rc1-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Robert Wisniewski <bob@watson.ibm.com>
Cc: Karim Yaghmour <karim@opersys.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andi Kleen <ak@muc.de>, Nikita Danilov <nikita@clusterfs.com>,
       LKML <linux-kernel@vger.kernel.org>, Tom Zanussi <zanussi@us.ibm.com>
In-Reply-To: <200501172242.j0HMgrR56646@kix.watson.ibm.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	 <200501172242.j0HMgrR56646@kix.watson.ibm.com>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 00:26:08 +0100
Message-Id: <1106004368.13265.490.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-17 at 17:42 -0500, Robert Wisniewski wrote:

> I believe (and Karim can correct me if I'm wrong) the idea is to have
> groups of events that can be disabled and enabled via a one word mask.  No
> checking multiple variables, no #ifdefing, something very streamlined.  By
> userspace I assume you mean post-processing, i.e., if the user/library/etc
> needs to log events they use the same simple facility.

Yes, I was talking about postprocessing in userspace. 

The logging of userspace events is a complete seperate issue. You have
to solve the timestamp problem and do the correlation to kernel events
in the postprocessing.

> I think we agree to optimize/streamline performance for the gathering and
> do work in the post processing.  There is an outstanding patch that makes
> strides in this direction.

Ack.

Have you any plans to seperate the layers into different pieces, so they
provide better reusability ?

tglx


