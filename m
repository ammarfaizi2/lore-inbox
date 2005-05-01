Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbVEAVBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVEAVBu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbVEAVBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:01:50 -0400
Received: from [140.247.233.35] ([140.247.233.35]:25844 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S262673AbVEAVBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:01:45 -0400
Date: Sun, 1 May 2005 17:01:42 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] init 1 kill khubd on 2.6.11
In-Reply-To: <200505012021.56649.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.44L0.0505011659130.19155-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 May 2005, Andrey Borzenkov wrote:

> Hub driver is using SIGKILL to terminate khubd. Unfortunately on a number of 
> distributions switching init levels implicitly does "killall -9", killing 
> khubd. The only way to restart it is to reload USB subsystem.
> 
> Is signal usage in this case really needed? What about replacing it with 
> simple flag (i.e. will patch be accepted)?

IMO the problem lies in those distributions.  They should not
indiscrimately kill processes when switching init levels.

Alan Stern

