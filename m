Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbTICDFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 23:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbTICDFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 23:05:15 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:1271 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261493AbTICDFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 23:05:11 -0400
Subject: Re: 2.6-test4 Traditional pty and devfs
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: hch@infradead.org, akpm@osdl.org
Content-Type: text/plain
Organization: 
Message-Id: <1062557567.846.2090.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Sep 2003 22:52:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
> On Tue, Sep 02, 2003 at 10:43:40AM -0700, Andrew Morton wrote:

>>> That's the magic use uid/gid of the process calling
>>> devfs_Register flag I killed.  With a big HEADSUP
>>> and explanation on lkml..
>>
>> So what is the impact here?  That libc5 will break if
>> the user is using devfs and old-style pty's?
>
> If he removed the pt_chown logic that is present with a
> stock libc5, yes.  I wouldn't know why someone would do
> that, though.

The problem may be more serious. There are lots of
apps that use the old-style PTYs w/o any libc help.

a. because that's the historic BSD way
b. so the user can choose a specific pty

For example, there's a "remserial" program
that abuses a PTY for giving access to a
serial port over the network. Apps trying to
use the port work pretty well, without any need
for source code changes or new kernel drivers.


