Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbTEMNqe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 09:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbTEMNqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 09:46:34 -0400
Received: from corky.net ([212.150.53.130]:42176 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S261231AbTEMNpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 09:45:35 -0400
Date: Tue, 13 May 2003 16:58:14 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: masud@googgun.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
Message-ID: <Pine.LNX.4.44.0305131645031.20904-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Masud wrote:

> But isn't swap crypting fun ? :-) Running encrypted swap is okay so long
> as we throw away the key after each session.  This can be easily (famous
> last words) achieved under crypto kernels. I am not certain if such
> functionaility is being contemplated for the Linux kernel along with the
> new cryptoloop stuff, if there isn't i can volunteer to put something
> like that in - if we are interested. Are we?

See http://loop-aes.sourceforge.net/
The README already explains how to use it as encrypted swap.  I've been
using it for quite a while without problems.

If you feel like volunteering for an encrypted swap, I suggest the model
used by OpenBSD.  Instead of using an encrypted swap dev with one random
key, they seem to have a per-process key and encrypt swap areas of the
process with its key.  When a process dies, its key dies with it, so the
swap space it used is considered clean without having to wait for an
override or a reboot.

Another fun project is encrypted hibernation (suspend-to-disk).  Once the
kernel contains a stable hibernation option, I'm certainly going to
encrypt it.


