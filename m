Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbUBWUML (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbUBWUML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:12:11 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:2600 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262016AbUBWUMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:12:09 -0500
Date: Mon, 23 Feb 2004 12:12:05 -0800
From: Paul Jackson <pj@sgi.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: hjlipp@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-Id: <20040223121205.2ef329fd.pj@sgi.com>
In-Reply-To: <20040223142215.GB30321@mail.shareable.org>
References: <20040216133418.GA4399@hobbes>
	<20040222020911.2c8ea5c6.pj@sgi.com>
	<20040222155410.GA3051@hobbes>
	<20040222125312.11749dfd.pj@sgi.com>
	<20040222225750.GA27402@mail.shareable.org>
	<20040222214457.6f8d2224.pj@sgi.com>
	<20040223142215.GB30321@mail.shareable.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyway that's irrelevant: the splitting change only affects shell _scripts_

Well, I wouldn't say 'irrelevant'.  Some might claim that this question
(what the major shell's do) is already known, but surely it does matter.

The shells _do_ need to find the path to the script file in the argv[]
passed to them, and the proposed change does alter the parsing of that
argv[].

The splitting does not affect only the scripts.  It also affects the
argv[] array presented to the shells, which may or may not deal with
such as we would like.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
