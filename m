Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTJ3JO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 04:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTJ3JO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 04:14:29 -0500
Received: from denise.shiny.it ([194.20.232.1]:28087 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S262176AbTJ3JO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 04:14:27 -0500
Date: Thu, 30 Oct 2003 10:14:23 +0100 (CET)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: Hans Reiser <reiser@namesys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
In-Reply-To: <3FA0C631.6030905@namesys.com>
Message-ID: <Pine.LNX.4.58.0310300943430.14300@denise.shiny.it>
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org>
 <20031030015212.GD8689@thunk.org> <3FA0C631.6030905@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Oct 2003, Hans Reiser wrote:

> >We can do this simply by associating UUID's to files, and storing the
> >the file metadata in a MySQL database which can be searched via
> >appropriate userspace libraries which we provide.
> >
> What a performance nightmare.  Updating a user space database every time
> a file changes --- let's move to a micro-kernel architecture for all of
> the kernel the same day.....;-)

If applications do not cooperate explicitly, there is no other way than
scanning the files after they have been modified. Sure, it's slow, but
there is no need to do the work immediately. Take into account the MS's
goal is to make the system seem fast to the normal (desktop) user. I
guess that system is aimed to speedup searches in word and text files,
not in the whole filesystem. And the normal desktop user do write files
only sometimes, so performance isn't a problem (unless you're copying a
whole CD of word files into the HD). I think that intercepting
open,write,close is enough to provide the same functionality in Linux.


--
Giuliano.
