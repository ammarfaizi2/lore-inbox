Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262539AbTC0MqV>; Thu, 27 Mar 2003 07:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262543AbTC0MqV>; Thu, 27 Mar 2003 07:46:21 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:7313 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S262539AbTC0MqU>; Thu, 27 Mar 2003 07:46:20 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] s390 update (1/9): s390 arch fixes.
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFEB906726.E92D0B9C-ONC1256CF6.00466DAC@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Thu, 27 Mar 2003 13:55:26 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 27/03/2003 13:56:56
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So yes, it's certainly not trivial (otherwise someone would have
> already done it), and I didn't say you should hurry to do it.  Also
> note that you don't have to do it all at once, start with #including
> the s390 files on s390x that are exactly the same, and after that
> one file after another can be cleaned up to be s390/s390x clean.

So we are in violent agreement :) From my point of view the merge
should start with the files in include/asm because common s390/s390x
headers would come in handy in the user space as well. The hack we
currently use is to move the s390 / s390x header into subfolders
and use a meta include file that reads in the one or the other
dependent on the compile options (-m31 vs -m64). E.g. for bitsops
this looks like this:

#ifndef __s390x__
#include <asm-s390/bitops.h>
#else
#include <asm-s390x/bitops.h>
#endif

blue skies,
   Martin


