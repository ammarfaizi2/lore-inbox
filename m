Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264760AbSLMPN6>; Fri, 13 Dec 2002 10:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbSLMPN6>; Fri, 13 Dec 2002 10:13:58 -0500
Received: from chaos.analogic.com ([204.178.40.224]:53894 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264760AbSLMPN4>; Fri, 13 Dec 2002 10:13:56 -0500
Date: Fri, 13 Dec 2002 10:23:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andrew Walrond <andrew@walrond.org>
cc: linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: Symlink indirection
In-Reply-To: <3DF9F780.1070300@walrond.org>
Message-ID: <Pine.LNX.3.95.1021213101227.2190A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2002, Andrew Walrond wrote:

> Quick question;
> 
> Is the number of allowed levels of symlink indirection (if that is the 
> right phrase; I mean symlink -> symlink -> ... -> file) dependant on the 
> kernel, or libc ? Where is it defined, and can it be changed?
> 
> TIA
> Andrew
> 

Since a symlink is just a file containing a name, the resulting path
length is simply the maximum path length that user-space tools allow.
This should be defined as "PATH_MAX". Posix defines this as 255 characters
but I think posix requires that this be the minimum and all file-name
handling buffers must be at least PATH_MAX in length.

A hard link is just another directory-entry for the same file. This,
therefore follows the same rules. There must be enough space on the
device to contain the number of directory entries, as well as enough
buffer length in the tools necessary to manipulate these "nested"
directories, which are not really "nested" at all. 


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


