Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSJZKYl>; Sat, 26 Oct 2002 06:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbSJZKYf>; Sat, 26 Oct 2002 06:24:35 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:27916 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262046AbSJZKXv>; Sat, 26 Oct 2002 06:23:51 -0400
X-Envelope-From: pavel@bug.ucw.cz
Date: Tue, 22 Oct 2002 01:08:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Robert Love <rml@tech9.net>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: [PATCH] pre-decoded wchan output
Message-ID: <20021021230856.GA120@elf.ucw.cz>
References: <1034882043.1072.589.camel@phantasy> <20021017205803.A7555@infradead.org> <1034885077.718.595.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034885077.718.595.camel@phantasy>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Can't you just left the old, nuerical one in even if CONFIG_KALLSYMS
> > ise set?  One ifdef less and far less surprises..
> 
> But why?  Save the call to get_wchan()...

Yes, and force users to update procps for no good reason. And "new"
procps will still need code to deal with get_wchan themselves... Plus
you loose information by killing get_wchan() -- two different wait
points in one function seems very possible to me.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
