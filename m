Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261586AbSIXHAz>; Tue, 24 Sep 2002 03:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261587AbSIXHAy>; Tue, 24 Sep 2002 03:00:54 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:44805 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S261586AbSIXHAy>;
	Tue, 24 Sep 2002 03:00:54 -0400
Message-Id: <200209240704.g8O74Ur01620@fokkensr.vertis.nl>
Content-Type: text/plain; charset=US-ASCII
From: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
To: Robert Love <rml@tech9.net>
Subject: Re: [PATCH] 32bit wraps and USER_HZ [64 bit counters], kernel 2.5.37
Date: Tue, 24 Sep 2002 09:04:25 +0200
X-Mailer: KMail [version 1.3.1]
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
References: <200209222207.g8MM7MM04998@fokkensr.vertis.nl> <200209232208.g8NM8bN05831@fokkensr.vertis.nl> <1032819194.25745.241.camel@phantasy>
In-Reply-To: <1032819194.25745.241.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 September 2002 00:13, Robert Love wrote:
> Having arrays statically created at NR_CPUS inside the task_struct is
> just gross.  Especially with NR_CPUS=32.  That is 128 bytes each!  Now
> with your changes, it is 256 bytes each!

I can understand that. However from a user point of view statistics are very 
usefull information, but not specifically the per-processor statistics.

I assume you mean to leave out the per-process statistics? Or do you mean to 
kmalloc the per-processor statistics when needed - that is: only when 
processes are running or maybe when the user has chosen to turn then on (some 
sysctl maybe)? 

Rolf
