Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968672AbWLEUfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968672AbWLEUfl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968673AbWLEUfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:35:40 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:52451 "EHLO mail.mnsu.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968672AbWLEUfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:35:40 -0500
Message-ID: <4575D7F4.3060707@mnsu.edu>
Date: Tue, 05 Dec 2006 14:35:00 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
CC: Marty Leisner <linux@rochester.rr.com>, linux-kernel@vger.kernel.org,
       bug-cpio@gnu.org, martin.leisner@xerox.com
Subject: Re: ownership/permissions of cpio initrd
References: <200612052024.kB5KOY1o023781@laptop13.inf.utfsm.cl>
In-Reply-To: <200612052024.kB5KOY1o023781@laptop13.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears to not be standard with fedora for sure... but while it 
origiginally was/is a Debian package it looks like there is source if 
you'd like to build it on other systems.  It was originally designed to 
tackle the exact problem you are confronting.

See:
http://freshmeat.net/projects/fakeroot/

About:
Fakeroot runs a command in an environment were it appears to have root 
privileges for file manipulation, by setting LD_PRELOAD to a library 
with alternative versions of getuid(), stat(), etc. This is useful for 
allowing users to create archives (tar, ar, .deb .rpm etc.) with files 
in them with root permissions/ownership. Without fakeroot one would have 
to have root privileges to create the constituent files of the archives 
with the correct permissions and ownership, and then pack them up, or 
one would have to construct the archives directly, without using the 
archiver.

Horst H. von Brand wrote:
> Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu> wrote:
>   
>> You can also use fakeroot(1).
>>     
>
> I think that is a debianism... not here on Fedora.
>   
