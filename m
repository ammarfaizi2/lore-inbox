Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTIQKuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 06:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbTIQKuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 06:50:12 -0400
Received: from math.ut.ee ([193.40.5.125]:65488 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262687AbTIQKuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 06:50:09 -0400
Date: Wed, 17 Sep 2003 13:49:58 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Ion Badulescu <ionut@badula.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: df hangs on nfs automounter in 2.6.0-current
In-Reply-To: <200309161558.h8GFwjRw025552@buggy.badula.org>
Message-ID: <Pine.GSO.4.44.0309171346550.12513-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You're going to have to figure out what amd is doing at that point --
> whether it's dead, spinning, waiting for a child process, or something
> else. Hanging on df is the expected behavior if amd is not responding to
> nfs requests.

It was actually a network configuration problem - I got a wrong IP via
DHCP and changed it to the right one manually. So network was
configured, portmap+amd started, IP address changed from under amd and
then amd hung. Fixing the network configuration made the hang go away so
I will probably not dig into the reasons why amd hangs indefinitely when
the IP chnages.

The kernel is certainly not at fault, it was my bad.

-- 
Meelis Roos (mroos@linux.ee)

