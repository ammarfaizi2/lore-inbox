Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUBWUOb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbUBWUOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:14:31 -0500
Received: from main.gmane.org ([80.91.224.249]:8383 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262031AbUBWUNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:13:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Juha Pahkala <juhis@trinity.is-a-geek.com>
Subject: Re: matroxfb not working after trying to upgrade to 2.6.3
Date: Mon, 23 Feb 2004 20:13:48 +0000 (UTC)
Message-ID: <loom.20040223T210849-45@post.gmane.org>
References: <6801343D94@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.243.128.98 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec <VANDROVE <at> vc.cvut.cz> writes:

> > CONFIG_FB_MATROX=m
> 
> Do not build it as a module. It is not going to work in usual configurations.

Building FB_MATROX into the kernel fixed the problem, so thanks alot Petr for
the quick help!!

> What reports 'matroxset -f /dev/fb0 -m' and 'matroxset -f /dev/fb1 -m' ?
> Does not second one report that /dev/fb1 is currently displayed on that
> output?

The fb0 was mapped to crtc1 and fb1 to crtc2, and even matroxset -m 5 option
wouldn't unmap them. But everything works now :)

juhis


