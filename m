Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267951AbTAIVqD>; Thu, 9 Jan 2003 16:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267984AbTAIVqD>; Thu, 9 Jan 2003 16:46:03 -0500
Received: from [81.2.122.30] ([81.2.122.30]:63751 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267951AbTAIVp7>;
	Thu, 9 Jan 2003 16:45:59 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301092154.h09Ls5SX005123@darkstar.example.net>
Subject: Re: detecting hyperthreading in linux 2.4.19
To: jamesclv@us.ibm.com
Date: Thu, 9 Jan 2003 21:54:05 +0000 (GMT)
Cc: lunz@falooley.org, linux-kernel@vger.kernel.org
In-Reply-To: <200301091337.04957.jamesclv@us.ibm.com> from "James Cleverdon" at Jan 09, 2003 01:37:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is there a way for a userspace program running on linux 2.4.19 to tell
> > the difference between a single hyperthreaded xeon P4 with HT enabled
> > and a dual hyperthreaded xeon P4 with HT disabled? The /proc/cpuinfos
> > for the two cases are indistinguishable.
> 
> I don't know of any way to do this in userland.  The whole point is that the 
> sibling processors are supposed to look like real ones.
> 
> You _could_ try running two processes simultaneously in tight spin loops for 
> 100 million cycles and comparing the amount of real time consumed.  That 
> would be rather unreliable and kludgey though.

If /proc/interrupts shows a processor is handling interrupts then it
is definitely a 'real' one.  If it isn't handling interrupts, it may
or may not be a 'real' one.  That's another unreliable and kludgey way
to tell the difference :-).

John.
