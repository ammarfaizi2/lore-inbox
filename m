Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbTJaLDJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 06:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbTJaLDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 06:03:09 -0500
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:14728 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id S263215AbTJaLDH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 06:03:07 -0500
Subject: Re: Things that Longhorn seems to be doing right
From: Kenneth Johansson <ken@kenjo.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Hans Reiser <reiser@namesys.com>, Erik Andersen <andersen@codepoet.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031030174809.GA10209@thunk.org>
References: <3F9F7F66.9060008@namesys.com>
	 <20031029224230.GA32463@codepoet.org> <20031030015212.GD8689@thunk.org>
	 <3FA0C631.6030905@namesys.com>  <20031030174809.GA10209@thunk.org>
Content-Type: text/plain
Message-Id: <1067598091.4434.19.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 31 Oct 2003 12:01:32 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-30 at 18:48, Theodore Ts'o wrote:

> The bottom line is that if a case can be made that some portion of the
> functionality required by WinFS needs to be in the kernel, and in the
> filesystem layer specifically, I'm all in favor of it.  But it has to

What about some way to quickly detect changes to the filesystem. That
would really help any type of indexing function to avoid scanning the
entire disk. 

It would help things like backup and even the locate database. 

It could be something simple as a modification number that increased
with every change combined with a size limited list of what every change
was. Then every indexing task could just store what the modification
number was last time it did it's work compare that number to the current
number and read all the changes from the change log. If the stored
modification number had fallen out of the log it has to go over the
entire filesystem but that would not have to happen that often with a
big enough log. 

Probably some optimisation have to be done to keep the log small you do
not want to store every putc as a separate event.

