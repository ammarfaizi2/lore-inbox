Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161346AbWKUVTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161346AbWKUVTJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161359AbWKUVTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:19:09 -0500
Received: from relay.rinet.ru ([195.54.192.35]:36823 "EHLO relay.rinet.ru")
	by vger.kernel.org with ESMTP id S1161346AbWKUVTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:19:05 -0500
Message-ID: <45636D31.7020506@mail.ru>
Date: Wed, 22 Nov 2006 00:18:41 +0300
From: Michael Raskin <a1d23ab4@mail.ru>
User-Agent: Thunderbird 2.0a1 (X11/20060809)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1+ memory problem
References: <45614A95.6090102@mail.ru>	<20061121003745.aeda4f7c.akpm@osdl.org>	<4563485B.3050801@mail.ru> <20061121114543.817fc06e.akpm@osdl.org>
In-Reply-To: <20061121114543.817fc06e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (relay.rinet.ru [195.54.192.35]); Wed, 22 Nov 2006 00:18:58 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 21 Nov 2006 21:41:31 +0300
> Michael Raskin <a1d23ab4@mail.ru> wrote:

Sorry for leaving lkml out of "To: " in previous post.

> Can you try to determine exactly which activity causes this to happen?  In
> particular, is it due to the X server?  If so, does any particular client
> cause it to happen?  Things which use 3d?
You were right, it's not because of personally X, but because of
environment I use.

Simplest example of reproducing code:

while true; do free | cat &>/dev/null; done

Looks like minimum (except of &>/dev/null not to involve console/xterm 
output - leaks well without it too).
