Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSHGCHe>; Tue, 6 Aug 2002 22:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSHGCHe>; Tue, 6 Aug 2002 22:07:34 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:43420 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S317068AbSHGCHd>;
	Tue, 6 Aug 2002 22:07:33 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200208070210.GAA26429@sex.inr.ac.ru>
Subject: Re: multiple connect on a socket
To: vasisht@eden.RUtgers.EDU (Vasisht Tadigotla)
Date: Wed, 7 Aug 2002 06:10:48 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0208062103210.4158-100000@er3.rutgers.edu> from "Vasisht Tadigotla" at Aug 7, 2 05:45:01 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>				Shouldn't it throw an error when I
> try to connect to it a second time ? Am I missing something here.

Yes, it used to return success once upon connection is complete.

When the connection is in progress, it returns EALREADY,
after this it returns EISCONN, but success is indicated when it goes
from unconnected to connected state. Maybe, this is wrong but it used
to work in this way.

Alexey
