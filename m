Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUDKFPL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 01:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbUDKFPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 01:15:10 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:28121 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262238AbUDKFPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 01:15:06 -0400
Message-ID: <4078D42C.1020608@nortelnetworks.com>
Date: Sun, 11 Apr 2004 01:14:20 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: want to clarify powerpc assembly conventions in head.S and	entry.S
References: <4077A542.8030108@nortelnetworks.com> <1081591559.25144.174.camel@gaston>
In-Reply-To: <1081591559.25144.174.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
