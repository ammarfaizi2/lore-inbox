Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWF3OMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWF3OMi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 10:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWF3OMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 10:12:38 -0400
Received: from ninilchik.quanstro.net ([66.92.161.167]:49058 "EHLO
	medicine-bow.quanstro.net") by vger.kernel.org with ESMTP
	id S932173AbWF3OMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 10:12:38 -0400
From: erik quanstrom <quanstro@quanstro.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Latchesar Ionkov <lionkov@gmail.com>
CC: Eric Sesterhenn <snakebyte@gmx.de>, Russ Cox <rsc@swtch.com>,
       linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
References: <1151535167.28311.1.camel@alice>
	<ee9e417a0606281555k3d954236y82b11336098762be@mail.gmail.com>
	<Pine.LNX.4.61.0606291300010.30453@yvahk01.tjqt.qr>
	<f158dc670606290816p4a7add09mf6742d632ec12d28@mail.gmail.com>
	<Pine.LNX.4.61.0606301544001.2313@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <Pine.LNX.4.61.0606301544001.2313@yvahk01.tjqt.qr>
Subject: Re: [V9fs-developer] [Patch] Dead code in fs/9p/vfs_inode.c
Message-Id: <20060630141220.BDD1B1B4F87@medicine-bow.quanstro.net>
Date: Fri, 30 Jun 2006 09:12:20 -0500 (CDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

saving ten bytes once is not a good reason to do much of anything
in an era of multi-megabyte embedded devices.

i think the argument against code written in speculation is that
it confuses what the code does right now, may never be used and
if used, may be used in a situation that masks a real error.

- erik

Jan Engelhardt <jengelh@linux01.gwdg.de> writes

| 
| 
| > The comment is longer than the 10 bytes we save :)
| 
| But comments are not compiled into the final binary,
| which is what I wanted to point out. So you always
| save your 10 bytes in the object file.
| 
| 
| Jan Engelhardt
