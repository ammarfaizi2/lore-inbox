Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbUJZDUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbUJZDUN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbUJZCxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:53:00 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43954 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262163AbUJZCio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:38:44 -0400
Subject: Re: How is user space notified of CPU speed changes?
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
In-Reply-To: <1098626510.24073.9.camel@localhost.localdomain>
References: <1098399709.4131.23.camel@krustophenia.net>
	 <1098444170.19459.7.camel@localhost.localdomain>
	 <1098508238.13176.17.camel@krustophenia.net>
	 <1098566366.24804.8.camel@localhost.localdomain>
	 <1098571334.29081.21.camel@krustophenia.net>
	 <1098626510.24073.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 22:38:43 -0400
Message-Id: <1098758323.9166.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-24 at 15:02 +0100, Alan Cox wrote:
> Are you trying to use tsc for delays or measure CPU speed. The original
> question you asked was about CPU speed and the two are very different.

No we are only using it as a cheap way to do microsecond level timing.
Are you saying we should just use gettimeofday() instead?
jack_get_microseconds() is called at least twice per period which can be
several thousand times per second.  Is the overhead of a system call
really low enough that this should work?  rdtsc is definitely cheap
enough.

Lee

