Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267466AbRGLKOe>; Thu, 12 Jul 2001 06:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267465AbRGLKOZ>; Thu, 12 Jul 2001 06:14:25 -0400
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:9975 "EHLO
	tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S267464AbRGLKOF>; Thu, 12 Jul 2001 06:14:05 -0400
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: "C. Slater" <cslater@wcnet.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Switching Kernels without Rebooting?
Date: Thu, 12 Jul 2001 05:07:09 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211C92A@mail0.myrio.com> <001501c10a71$68c66820$0200000a@laptop>
In-Reply-To: <001501c10a71$68c66820$0200000a@laptop>
MIME-Version: 1.0
Message-Id: <01071205133300.23879@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2001, C. Slater wrote:
>Would anyone else like to point out some other task somewhat related 
>and have me do it? :-)
>
>> > Before you even try switching kernels, first implement a process
>> > checkpoint/restart. The process must be resumed after a boot
>> > using the same
>> > kernel, with all I/O resumed. Now get it accepted into the kernel.
>> 
>> Hear, hear!  That would be a useful feature, maybe not network servers, 
>> but for pure number crunching apps it would save people having to write 
>> all the state saving and recovery that is needed now for long term 
>> computations.
>
>Get a computer with hibernation support. That's just about what it is.

Bzzzt wrong anser. Hibernation stops the entire kernel. checkpoint restart
stops processes, saves the entire state of the process. hibernation
is just halt the processor.

>> 
>> For bonus points, make it work for clusters to synchronously save and
>> restore state for the apps running on all the nodes at once...
>
>Bash script.

doesn't work - remember once the kernel is suspended it can't tell
another system that is has done so.

A full checkpoint/restart can potentially allow a process to migrate
from one node to another. It also allows other processing to be done
while the process is checkpointed:

	a. how do you reconstruct a software raid 5 while the system
	   is "suspended"
	b. how do you migrate to a different platform if the system is
	   suspended

Answer - you can't.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
