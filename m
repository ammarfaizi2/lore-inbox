Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWGCWTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWGCWTE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWGCWTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:19:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16873 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932157AbWGCWTC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:19:02 -0400
Subject: Re: Driver for Microsoft USB Fingerprint Reader
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Bonekeeper <thehazard@gmail.com>
Cc: Greg KH <greg@kroah.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com>
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
	 <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com>
	 <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com>
	 <44A95F12.8080208@gmail.com>
	 <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com>
	 <20060703214509.GA5629@kroah.com>
	 <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Jul 2006 23:35:54 +0100
Message-Id: <1151966154.16528.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-03 am 18:11 -0400, ysgrifennodd Daniel Bonekeeper:
> That's one problem: I don't want to create one more userspace
> interface for that. I suppose that all the hundreds of fingerprint
> readers that ships with a SDK have their own way of doing that.. that

The very cheap readers all appear to be fairly crude image scanners, and
they even lack hardware encryption/perturbation so they are actually of
very limited value.

> looks awfull to me, even though I believe that currently there isn't
> any uniform way of working with fingerprint readers... shouldn't we
> have a way to classify devices ? For example, if I want to list all

They vary from "low res bitmap" and the rest in software through "low
res bitmap mangled by specific device instance unique scheme" (1)
through to smart card based external tamperproof boxes that authenticate
the smartcard with the fingerprint and the host typically via PAM in
user space.

That's a huge range of devices with little in common.

Alan
(1) Think about what happens if you don't have this. Its possible to
steal a result then reverse engineer a "finger" on your own laptop to
produce the same result.
