Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVEROjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVEROjJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVEROit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:38:49 -0400
Received: from duempel.org ([81.209.165.42]:17938 "HELO duempel.org")
	by vger.kernel.org with SMTP id S262254AbVEROhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:37:23 -0400
Date: Wed, 18 May 2005 16:37:12 +0200
From: Max Kellermann <max@duempel.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Detecting link up
Message-ID: <20050518143712.GA21883@roonstrasse.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <428B1A60.6030505@inescporto.pt> <20050518134031.53a3243a@phoebee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518134031.53a3243a@phoebee>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005/05/18 13:40, Martin Zwickel <martin.zwickel@technotrend.de> wrote:
> On Wed, 18 May 2005 11:35:12 +0100
> Filipe Abrantes <fla@inescporto.pt> bubbled:
> > I need to detect when an interface (wired ethernet) has link up/down.
> > Is  there a system signal which is sent when this happens? What is the
> > best  way to this programatically?
> 
> mii-tool?

A thought on a related topic:

When a NIC driver knows that there is no link, why does it even try to
transmit a packet? It could return immediately with an error code,
without applications having to wait for a timeout.

(I had a quick peek at two drivers, and they don't check the link
status)

Max

