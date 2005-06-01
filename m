Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVFABlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVFABlL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 21:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVFABlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 21:41:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42383 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261211AbVFABk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 21:40:57 -0400
Date: Tue, 31 May 2005 18:40:48 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Ian Leonard <ian@smallworld.cx>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org,
       Ian Abbott <abbotti@mev.co.uk>
Subject: Re: 2.4.30 - USB serial problem
Message-Id: <20050531184048.5ef9fd44.zaitcev@redhat.com>
In-Reply-To: <mailman.1117130162.21749.linux-kernel2news@redhat.com>
References: <mailman.1117130162.21749.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 1.9.9 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2005 18:52:10 +0100, Ian Leonard <ian@smallworld.cx> wrote:

> We recently upgraded from 2.4.24 to 2.4.28 and the problem described 
> below appeared. I have tested it on 2.4.30 and the fault still exists.
>[...]
> Examining the packet that caused the problem showed it was very similar 
> to the others but it contained 0x0a. This obviously stuck out as being a 
> candidate for some sort of translation problem.

The above looks almost too obvious but for this:

> I also built a 2.4.28 kernel with the ftdi_sio and usbserial code from 
> the 2.4.24 release. It also failed. This was a surprise and I am 
> wondering of I did it correctly.

Did you nail down a scenario which we can debug? Frankly it's not credible
that transplanted usbserial and ftsi_sio would fail to work. I know that
I changed quite a bit between 2.4.24 and 2.4.28, but your experiment
undoes that.

-- Pete
