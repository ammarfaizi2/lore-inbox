Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVCIAEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVCIAEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVCIAA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 19:00:59 -0500
Received: from loon.tech9.net ([69.20.54.92]:57575 "EHLO loon.tech9.net")
	by vger.kernel.org with ESMTP id S262414AbVCIAAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 19:00:19 -0500
Subject: Re: 2.6.11-mm2
From: Robert Love <rlove@rlove.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1110325890l.6106l.1l@werewolf.able.es>
References: <20050308033846.0c4f8245.akpm@osdl.org>
	 <1110325018l.6106l.0l@werewolf.able.es>
	 <1110325442.30255.8.camel@localhost>
	 <1110325890l.6106l.1l@werewolf.able.es>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 19:02:46 -0500
Message-Id: <1110326566.30255.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 23:51 +0000, J.A. Magallon wrote:

> Ahh, damn, that explains it. I use a main thread that does nothing but
> wait for the worker threads. So it sure gets moved to CPU0, but as it
> does not waste CPU time, I do not see it...
> 
> Thanks. Will see what can I do with my threads. cpusets, perhaps...

Affinity is inherited.

Start the threads in a shell script that runs taskset on itself.  Or
just modify this program to have the main thread do sched_setaffinity()
on itself.

	Robert Love


