Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbRCTDfr>; Mon, 19 Mar 2001 22:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129598AbRCTDfi>; Mon, 19 Mar 2001 22:35:38 -0500
Received: from chromium11.wia.com ([207.66.214.139]:65036 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S129495AbRCTDf0>; Mon, 19 Mar 2001 22:35:26 -0500
Message-ID: <3AB6D0A5.EC4807E3@chromium.com>
Date: Mon, 19 Mar 2001 19:38:13 -0800
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: user space web server accelerator support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been working for a while on a user-space web server accelerator (as
opposed to a kernel space accelerator, like TUX). So far I've had very
promising results and I can achieve performance (spec) figures
comparable to those of TUX.

Although my implementation is entirely sitting in user space, I need
some cooperation form the kernel for efficiently forwarding network
connections from the accelerator to the full-fledged Apache server.

I've made a little kernel hack (mostly lifted out of the TUX and khttpd
code) to forward a live socket connection from an application to
another. I'd like to clean this up such that my users don't have to mock
with their kernel to get my accelerator to work.

Would it be a major heresy to ask for a new system call?

If so I could still hide my stuff in a kernel module and snatch an
unused kernel call for my private use (such as the one allotted for
tux). The problem with this is that the kernel only exposes the "right"
symbols to the modules if either khttp or ipv6 are compiled as modules.

How could this be fixed?

TIA, ciao,

 - Fabio


