Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752048AbWCBTfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbWCBTfk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbWCBTfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:35:39 -0500
Received: from smtp-out.google.com ([216.239.45.12]:23130 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1752048AbWCBTfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:35:39 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
	b=Gyy0zygHieBKxiWRyDvSiVKh6djOv3+yCsgIZjOc/cn6FlNCPGs82xVjTHWlZ7g32
	xfzp3nqejAOJrLBvevO5w==
Message-ID: <440748FD.8010806@google.com>
Date: Thu, 02 Mar 2006 11:35:25 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: x86_64 compile spewing hundreds of warnings - started 2.6.15-git8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

between 2.6.15-git7 and 2.6.15-git8 we started getting hundreds of 
compile warnings:

-git7: http://test.kernel.org/20295/debug/test.log.0
-git8: http://test.kernel.org/20402/debug/test.log.0

Warnings look like this:

include/asm/bitops.h: In function `load_elf32_binary':
include/asm/bitops.h:30: warning: read-write constraint does not allow a 
register
include/asm/bitops.h:30: warning: read-write constraint does not allow a 
register
include/asm/bitops.h:65: warning: read-write constraint does not allow a 
register
include/asm/bitops.h:65: warning: read-write constraint does not allow a 
register
include/asm/bitops.h:30: warning: read-write constraint does not allow a 
register
include/asm/bitops.h:30: warning: read-write constraint does not allow a 
register
include/asm/bitops.h:65: warning: read-write constraint does not allow a 
register
include/asm/bitops.h:65: warning: read-write constraint does not allow a 
register
include/asm/bitops.h:30: warning: read-write constraint does not allow a 
register
include/asm/bitops.h:30: warning: read-write constraint does not allow a 
register
include/asm/bitops.h:65: warning: read-write constraint does not allow a 
register
include/asm/bitops.h:65: warning: read-write constraint does not allow a 
register


What do these mean? And how do we get rid of it?

Presumably caused by this:

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=636dd2b7def5c9c72551b51d4d516a65c269de08

or this:

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=92934bcbf96bc9dc931c40ca5f1a57685b7b813b
