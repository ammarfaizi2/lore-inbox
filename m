Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUKWOBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUKWOBy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 09:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUKWOBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 09:01:53 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:14830 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261253AbUKWOAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 09:00:42 -0500
Date: Tue, 23 Nov 2004 15:00:37 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Amit Gud <amitgud1@gmail.com>
cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: file as a directory
In-Reply-To: <2c59f00304112301467b411a46@mail.gmail.com>
Message-ID: <Pine.LNX.4.53.0411231458450.28979@yvahk01.tjqt.qr>
References: <2c59f00304112205546349e88e@mail.gmail.com> 
 <200411221759.iAMHx7QJ005491@turing-police.cc.vt.edu>  <41A23566.6080903@namesys.com>
  <Pine.LNX.4.53.0411222002380.21595@yvahk01.tjqt.qr>
 <2c59f00304112301467b411a46@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Correct me if I'm wrong, but the best way I know whether a file should
>be treated as directory or as a file (atleast how I've implemented it)
>depends upon the context (how the file is accessed) in the user-space
>and this context is reflected in the kernel space in the flags of the
>struct nameidata. So ...

And there I see a problem! The open() call (kernel: sys_open) allows to open
both files and directories in the standard operation.
There is the O_DIRECTORY user-space flag, but which only says "it must be a
directory". So there's something missing to say "must be a file".

Hell will freeze over if a reiser4 "object" can be ANY type, blockdev,
chardev, symlink, <think something up>.


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
