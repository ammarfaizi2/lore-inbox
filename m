Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbTBDOHV>; Tue, 4 Feb 2003 09:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbTBDOHV>; Tue, 4 Feb 2003 09:07:21 -0500
Received: from mario.gams.at ([194.42.96.10]:27944 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S267267AbTBDOHU>;
	Tue, 4 Feb 2003 09:07:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Axel Kittenberger <Axel.Kittenberger@maxxio.com>
Organization: Maxxio Technologies
To: Jesse Pollard <pollard@admin.navo.hpc.mil>, linux-kernel@vger.kernel.org
Subject: Re: Patch: oom_kill
Date: Tue, 4 Feb 2003 15:13:29 +0100
User-Agent: KMail/1.4.1
Cc: riel@nl.linux.org
References: <200302041332.05096.Axel.Kittenberger@maxxio.com> <200302040807.03214.pollard@admin.navo.hpc.mil>
In-Reply-To: <200302040807.03214.pollard@admin.navo.hpc.mil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302041513.29093.Axel.Kittenberger@maxxio.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And what about processes that get reparented to init? These could be
> causing the OOM. I didn't think that the p_ptr was null when reparenting
> happens.

Okay good, should we use the "original parent" instead?

Yes, I'm not absolutly not sure if the != NULL expression is necessary, Don't 
know enough about the task structering for this. I tried without and the 
machine at least didn't crash, but just wanted to be safe.
