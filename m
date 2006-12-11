Return-Path: <linux-kernel-owner+w=401wt.eu-S937629AbWLKTyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937629AbWLKTyE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937631AbWLKTyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:54:04 -0500
Received: from vulpecula.futurs.inria.fr ([195.83.212.5]:47232 "EHLO
	vulpecula.futurs.inria.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937629AbWLKTyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:54:01 -0500
Message-ID: <457DB755.1000100@tremplin-utc.net>
Date: Mon, 11 Dec 2006 20:53:57 +0100
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
MIME-Version: 1.0
To: Kyle McMartin <kyle@ubuntu.com>
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: noexec=on doesn't work
References: <457B0FD7.2030804@comcast.net> <20061209200323.GA21514@athena.road.mcmartin.ca>
In-Reply-To: <20061209200323.GA21514@athena.road.mcmartin.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

12/09/2006 09:03 PM, Kyle McMartin wrote/a écrit:
> On Sat, Dec 09, 2006 at 02:34:47PM -0500, John Richard Moser wrote:
>> I have filed this as a distro bug with Ubuntu; it may be their issue, I
>> haven't dug deep enough to find out.  I am posting this here to disperse
>> the information breadth-first instead of depth-first, which will shorten
>> the bug's life cycle if it turns out to be an upstream bug.
>>
> 
> NX requires the 64-bit page table entries (ie, PAE) which requires
> CONFIG_HIGHMEM64G.

Somehow there is a problem: a user can explicitly put "noexec=on" and it 
will be silently ignored if the kernel doesn't have PAE support. I guess 
that currently no message is written because "noexec=on" is the 
_default_. Still, it would be fair to the user who added "noexec=on" on 
its command line that if it is not respected, either because the 
hardware doesn't support it or because the kernel doesn't support it, we 
display a warning saying it's hopeless.

I'll send a patch if it seems meaningful to you,
c u
Eric



