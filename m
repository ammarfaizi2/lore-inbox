Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbVLFLhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbVLFLhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 06:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVLFLhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 06:37:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38622 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932136AbVLFLhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 06:37:18 -0500
Date: Tue, 6 Dec 2005 06:37:04 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: David Engraf <engraf.david@netcom-sicherheitstechnik.de>
Cc: "'Arjan van de Ven'" <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: [PATCH] Win32 equivalent to GetTickCount systemcall (i386)
Message-ID: <20051206113704.GE31785@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1133865880.2858.42.camel@laptopd505.fenrus.org> <000001c5fa57$797051b0$0a016696@EW10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c5fa57$797051b0$0a016696@EW10>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 12:23:23PM +0100, David Engraf wrote:
> > (and.. wait.. isn't that called gettimeofday() )
> Not really gettimeofday is based on the date and time, but what if the user
> changes the date, the counter would also change.

If you want a monotonic clock, just use clock_gettime (CLOCK_MONOTONIC, &ts);

	Jakub
