Return-Path: <linux-kernel-owner+w=401wt.eu-S932841AbXASS4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932841AbXASS4I (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 13:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbXASS4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 13:56:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50343 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932841AbXASS4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 13:56:06 -0500
Subject: Re: Threading...
From: Arjan van de Ven <arjan@infradead.org>
To: Brian McGrew <brian@visionpro.com>
Cc: linux-kernel@vger.kernel.org, fedora-users@rdhat.com
In-Reply-To: <C1D65141.16E37%brian@visionpro.com>
References: <C1D65141.16E37%brian@visionpro.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 19 Jan 2007 19:55:41 +0100
Message-Id: <1169232941.3055.555.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-19 at 10:43 -0800, Brian McGrew wrote:
> I have a very interesting question about something that we're seeing
> happening with threading between Fedora Core 3 and Fedora Core 5.  Running
> on Dell PowerEdge 1800 Hardware with a Xeon processor with hyper-threading
> turned on.  Both systems are using a 2.6.16.16 kernel (MVP al la special).
> 
> We have a multithreaded application that starts two worker threads.  On
> Fedora Core 3 both of these we use getpid() to get the PID of the thread and
> then use set_afinity to assign each thread to it's own CPU.  Both threads
> run almost symmetrically even on their given CPU watching the system
> monitor.

this is odd; even in FC3 getpid() is supposed to return the process ID
not the thread ID

> What am I missing?  What do I need to do in FC5 or the kernel or the
> threading library to get my threads to run in symmetric parallel again???

you should fix the app to use something like pthread_self() instead...
(or the highly unportable gettid() but that would just be horrible)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

