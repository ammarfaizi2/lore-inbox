Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbVJGPlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbVJGPlr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 11:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030442AbVJGPlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 11:41:47 -0400
Received: from agmk.net ([217.73.31.34]:3857 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S1030432AbVJGPlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 11:41:47 -0400
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [2.6] binfmt_elf bug (exposed by klibc).
Date: Fri, 7 Oct 2005 17:41:41 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200510071533.j97FX9Wp018589@laptop11.inf.utfsm.cl>
In-Reply-To: <200510071533.j97FX9Wp018589@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200510071741.41929.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia piątek, 7 października 2005 17:33, Horst von Brand napisał:
> Paweł Sikora <pluto@agmk.net> wrote:
> > Dnia piątek, 7 października 2005 15:46, Horst von Brand napisał:
>
> [...]
>
> > > binutils-2.16.91.0.2-4 doesn't. It looks like you are using broken
> > > tools.
> >
> > I didn't say that is (or not) a binutils bug.
> > I'm only saying that kernel is killng a valid micro application.
>
> If binutils generates an invalid executable, it is not a valid application.

ehh, please look again at my first post :)
binutils-2.16 generates VALID app with .text/.interp and *without* .bss.
kernel always calls padzero() for the .bss section inside load_elf_binary().
finally it kills a valid app. did i miss something?

-- 
The only thing necessary for the triumph of evil
  is for good men to do nothing.
                                           - Edmund Burke
