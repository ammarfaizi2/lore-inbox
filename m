Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbTHSTiE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbTHSThr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:37:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31495 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261385AbTHSTfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:35:51 -0400
Message-ID: <3F427BE0.2040306@zytor.com>
Date: Tue, 19 Aug 2003 12:34:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
References: <MDEHLPKNGKAHNMBLJOLKIEMNFDAA.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEMNFDAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
>>>	There is no mechanism that is guaranteed to terminate a
>>>process other than
>>>sending yourself an exception that is not caught. So in cases
>>>where you must
>>>guarantee that your process terminates, it is perfectly
>>>reasonable to send
>>>yourself a SIGILL.
> 
> 
>>exit(2)?
> 
> 
> 	And what if a registered 'atexit' function needs to acquire a mutex that is
> held by a thread that's in an endless loop? What if a standard I/O stream
> has buffered data for a local disk that failed? I'm looking for a mechanism
> that is guaranteed to terminate a process immediately.
> 

Correction...

_exit(2).

There is no exit(2); I was talking about _exit(2) and you're talking
about exit(3).

_exit(2) *is* guaranteed to terminate a process immediately.

	-hpa

