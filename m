Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVCGONz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVCGONz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 09:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVCGONz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 09:13:55 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:63398 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261159AbVCGONx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 09:13:53 -0500
To: Michelle Konzack <linux4michelle@freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: diff command line?
References: <200503051048.00682.gene.heskett@verizon.net>
	<20050305161822.H3282@flint.arm.linux.org.uk>
	<20050307105153.GL26452@freenet.de>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 07 Mar 2005 14:13:50 +0000
In-Reply-To: <20050307105153.GL26452@freenet.de> (Michelle Konzack's message
 of "Mon, 7 Mar 2005 11:51:53 +0100")
Message-ID: <tnxpsybczmp.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michelle Konzack <linux4michelle@freenet.de> wrote:
> Am 2005-03-05 16:18:24, schrieb Russell King:
>> On Sat, Mar 05, 2005 at 10:48:00AM -0500, Gene Heskett wrote:
>> > What are the options normally used to generate a diff for public 
>> > consumption on this list?  
>> 
>> diff -urpN orig new
>
> This is what I using curently
>
> diff -Nurp src.orig/linux src/linux >src.diff/linux
>
> Now I have a question: How can one create this Type of patches ?
> (Curently I am using scripts to strip "src.orig" and "src")

Two ways:
    $ mv src.orig/linux linux.orig
    $ mv src/linux linux
    $ diff -Nurp linux.orig linux

or
    $ diff -Nurp src.orig/linux src/linux | filterdiff --strip=1

Catalin

