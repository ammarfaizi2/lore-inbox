Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTIVTOl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTIVTOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:14:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:26314 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263274AbTIVTOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:14:39 -0400
Date: Mon, 22 Sep 2003 11:55:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Cc: alistair@devzero.co.uk, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.0-test5-mm4
Message-Id: <20030922115509.4d3a3f41.akpm@osdl.org>
In-Reply-To: <20030922143605.GA9961@gemtek.lt>
References: <20030922013548.6e5a5dcf.akpm@osdl.org>
	<200309221317.42273.alistair@devzero.co.uk>
	<20030922143605.GA9961@gemtek.lt>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zilvinas Valinskas <zilvinas@gemtek.lt> wrote:
>
> Btw Andrew ,
> 
> this change  "Synaptics" -> "SynPS/2" - breaks driver synaptic driver
> from http://w1.894.telia.com/~u89404340/touchpad/index.html. 
> 
> 
> -static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/
> 2", "ImPS/2", "ImExPS/2", "Synaptics"}; 
> +static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};

You mean it breaks the XFree driver?  Is it just a matter of editing
XF86Config to tell it the new protocl name?

Either way, it looks like a change which should be reverted?

