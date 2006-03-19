Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWCSW7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWCSW7q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 17:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWCSW7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 17:59:46 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:21428 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751178AbWCSW7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 17:59:45 -0500
Subject: Re: Question regarding to store file system metadata in database
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <4ae3c140603182048k55d06d87ufc0b9f0548574090@mail.gmail.com>
References: <4ae3c140603182048k55d06d87ufc0b9f0548574090@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 19 Mar 2006 23:06:25 +0000
Message-Id: <1142809585.14592.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-03-18 at 23:48 -0500, Xin Zhao wrote:
> database system. I ran a test on a mysql database: I inserted about
> 1.2 million such kind of records into an initially empty mysql
> database. Average insertion rate is about 300 entries per second,

Thats extremely slow for a file system. 

> Then I am a little curious why only few people use database to store
> file system metadata, although I know WinFS plans to use database to
> manage metadata. 

The one well known example of a database as file system (or was well
known) was the Pick OS (now defunct although the database system lives
on). They did manage to build an OS which had a database as a file
system.

The thing is a database and a file system are the same thing anyway.
You'll find the same structures like B trees used in some for example.
They are just optimised for different kinds of queries. If you want to
know whether a db as fs works , build a prototype and see - you've
already taken the first step and with FUSE you can prototype the rest in
user space.

Alan

