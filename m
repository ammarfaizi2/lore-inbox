Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317642AbSFRWAR>; Tue, 18 Jun 2002 18:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317643AbSFRWAQ>; Tue, 18 Jun 2002 18:00:16 -0400
Received: from 216-175-173-2.client.dsl.net ([216.175.173.2]:55292 "EHLO
	mail.fl.adelantetech.com") by vger.kernel.org with ESMTP
	id <S317642AbSFRWAO>; Tue, 18 Jun 2002 18:00:14 -0400
Subject: RE: VMM - freeing up swap space
From: Jelle Foks <jelle@frontierd-us.com>
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
Cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
In-Reply-To: <EE83E551E08D1D43AD52D50B9F5110927E7AA0@ntserver2>
References: <EE83E551E08D1D43AD52D50B9F5110927E7AA0@ntserver2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 18 Jun 2002 18:00:14 -0400
Message-Id: <1024437615.2891.5.camel@zoot>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-18 at 13:26, Gregory Giguashvili wrote:
> >Sure. Execute `swapoff -a`, followed by `swapon -a`. This is no joke.
> 
> Thanks. That really helped, let alone the fact that swapoff is a lengthy
> operation (I can understand why), the resulting memory was even less than
> the original RAM+swap size. I guess that happened because of memory
> rearrangements when moving it up to RAM.

Or mmapped files for which pages had been read into memory, but were
freed to make room for your large data allocations.

Jelle

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


