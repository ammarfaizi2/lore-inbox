Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVLHQUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVLHQUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbVLHQUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:20:37 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.30]:29495 "EHLO smtp1.wanadoo.fr")
	by vger.kernel.org with ESMTP id S932194AbVLHQUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:20:36 -0500
X-ME-UUID: 20051208162035711.AD9D91C0022E@mwinf0101.wanadoo.fr
Subject: Re: How to enable/disable security features on mmap() ?
From: Xavier Bestel <xavier.bestel@free.fr>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Emmanuel Fleury <emmanuel.fleury@labri.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0512081051250.13997@chaos.analogic.com>
References: <43983EBE.2080604@labri.fr>
	 <1134051272.2867.63.camel@laptopd505.fenrus.org>
	 <43984154.5050502@labri.fr>  <43984595.1090406@labri.fr>
	 <1134053349.2867.65.camel@laptopd505.fenrus.org> <4398493E.50508@labri.fr>
	 <Pine.LNX.4.61.0512081011020.32448@chaos.analogic.com>
	 <1134056272.2867.73.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0512081051250.13997@chaos.analogic.com>
Content-Type: text/plain
Message-Id: <1134058814.1615.176.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 08 Dec 2005 17:20:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 17:08, linux-os (Dick Johnson) wrote:

> An 8 megabyte variation is absolutely insane. It follows the "If a
> little is good, more must be better..." theory. The purpose of
> the random stack start, initially proposed by me BTW, was to
> prevent stack-exploit code from being able to hard-code addresses
> on the stack. Being off by one byte is enough, 8192 was originally
> discussed and, I thought, adopted. Eight megabytes is absurd and has
> no technical basis.

If you only randomize by one or two bytes, the attacker just has to
retry once or twice to have his exploit work. Even once in 1024 may be
too much for some security-conscious people. The larger the area (with a
fixed step), the less statistically efficient the rootkit.

	Xav


