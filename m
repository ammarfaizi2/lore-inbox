Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbUKCUAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbUKCUAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUKCT55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:57:57 -0500
Received: from main.gmane.org ([80.91.229.2]:35724 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261833AbUKCT46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:56:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 03 Nov 2004 20:56:27 +0100
Message-ID: <yw1xy8hig104.fsf@ford.inprovide.com>
References: <200411030751.39578.gene.heskett@verizon.net> <20041103143348.GA24596@outpost.ds9a.nl>
 <200411031124.19179.gene.heskett@verizon.net>
 <Pine.LNX.4.61.0411031133590.14117@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200.80-202-166.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:3DDfO2zuPaAdOeThWNafp8tsils=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os <linux-os@chaos.analogic.com> writes:

> The fix is to fix the code. Your temporary fix is to use
> Ctrl-Alt-backspace to kill the X11 server (the parent).

The X server is not the parent.  The desktop manager (or whatever
those beasts are called) is more likely to be.

> All these little windows and icons are the 'children' of the X
> server.

The X server manages a set of windows, arranged in a logical tree
structure, with all windows ultimately descending from the root
windows.  The parent-child relationships between windows should under
no circumstance be confused, or compared, with that between processes.
Any process, on any machine on the network, can, given enough
privileges, create subwindows of any window on the X server.  Windows
and process belong to different worlds, the only connection between
which is that processes create windows, simply since anything that
happens in the computer is done by a process (or interrupt handler).

Am I really reading this on linux-kernel?

-- 
Måns Rullgård
mru@inprovide.com

