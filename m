Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbUCVEAO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 23:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUCVEAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 23:00:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:45221 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261671AbUCVEAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 23:00:09 -0500
Date: Sun, 21 Mar 2004 19:57:07 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] error value for opening block devices
Message-Id: <20040321195707.14a5a0f8.rddunlap@osdl.org>
In-Reply-To: <405C195B.10004@redhat.com>
References: <405C195B.10004@redhat.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2004 02:13:47 -0800 Ulrich Drepper wrote:

| Opening a non-existing block device currently yields an ENXIO error.
| Doing the same for char devices produces the correct error ENODEV.
| 
| The attached patch fixes the symptoms.  Somebody with more knowledge
| will have to decide whether there are any negative side effects.

(now that this is merged...)

Isn't this going in the wrong direction, or am I just
mis-interpreting SUSv3?

Compare LSB bugzilla #115:
http://bugs.linuxbase.org/show_bug.cgi?id=115

open - open a file

...

ERRORS

[ENXIO]
O_NONBLOCK is set, the named file is a FIFO, O_WRONLY is set, and
no process has the file open for reading.

[ENXIO]
The named file is a character special or block special file, and
the device associated with this special file does not exist.


(Note:  ENODEV is not listed as a possible return value.)

--
~Randy
"You can't do anything without having to do something else first."
-- Belefant's Law
