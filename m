Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbUDKFnM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 01:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbUDKFnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 01:43:12 -0400
Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:3883
	"EHLO 2003SERVER.sbs2003.local") by vger.kernel.org with ESMTP
	id S262244AbUDKFnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 01:43:09 -0400
thread-index: AcQfiDTvhISSR0pPTYqc7hWgLLc64A==
X-Sieve: Server Sieve 2.2
Date: Sun, 11 Apr 2004 06:45:33 +0100
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Chris Friesen" <cfriesen@nortelnetworks.com>
Message-ID: <000001c41f88$35133100$d100000a@sbs2003.local>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: <Administrator@vger.kernel.org>
Cc: "linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
Subject: Re: want to clarify powerpc assembly conventions in head.S and	entry.S
X-Mailer: Microsoft CDO for Exchange 2000
References: <4077A542.8030108@nortelnetworks.com> <1081591559.25144.174.camel@gaston>
In-Reply-To: <1081591559.25144.174.camel@gaston>
Content-Type: text/plain;
	format=flowed;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
Envelope-to: paul@sumlocktest.fsnet.co.uk
X-me-spamlevel: not-spam
Content-Class: urn:content-classes:message
Importance: normal
X-me-spamrating: 13.995314
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-OriginalArrivalTime: 11 Apr 2004 05:45:34.0125 (UTC) FILETIME=[352B25D0:01C41F88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin Herrenschmidt wrote:
> On Sat, 2004-04-10 at 17:41, Chris Friesen wrote:

>>According to the docs I read, r0 and r3-12 are caller-saves.  They seem
>>to be saved in EXCEPTION_PROLOG_2 (head.S) and restored in
>>ret_from_except() (entry.S).  Thus, if I add code in entry.S I should be
>>able to use any of those registers, without having to worry about
>>restoring them myself--correct?
>
> Yes. For interrupts or faults that's right. Syscalls are a bit special
> though.

You knew this was coming...  What's special about syscalls?  There's the
r3 thing, but other than that...

Thanks for your help with this stuff.  As I've been slowly wrapping my
head around it I've been continuously wishing for some kind of design
rules document describing the various paths through the assembly code,
along with register conventions and such.  I eventually did find the
conventions linked off the penguinppc website, but it was not obvious
from just reading the code or the ppc stuff in the Documentation directory.

Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


