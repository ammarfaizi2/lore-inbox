Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130215AbRB1PQM>; Wed, 28 Feb 2001 10:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130214AbRB1PQC>; Wed, 28 Feb 2001 10:16:02 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:15190 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S130211AbRB1PPm>;
	Wed, 28 Feb 2001 10:15:42 -0500
Message-ID: <20010228161540.B19929@win.tue.nl>
Date: Wed, 28 Feb 2001 16:15:40 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Glenn McGrath <bug1@optushome.com.au>,
        Helge Hafting <helgehaf@idb.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs and /proc/ide/hda
In-Reply-To: <3A9CCA76.3E6AB93A@optushome.com.au> <3A9CD2F3.E26A2884@idb.hist.no> <3A9CD304.26C3A568@optushome.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A9CD304.26C3A568@optushome.com.au>; from Glenn McGrath on Wed, Feb 28, 2001 at 09:29:24PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2001 at 09:29:24PM +1100, Glenn McGrath wrote:

> Well leaving it the way it is doesnt make much sense either really, it
> refers to devices that dont exist.

You are mistaken. The existence of a device is unrekated to the name
someone uses to access it. You may well use /tmp/myowndisk instead
of /dev/hda. In fact some programs do precisely that and use mknod()
to temporarily create a device node with known name, since they
cannot guess what name you may be using for the device.

The kernel also uses names, for example in its boot messages,
and it will call the device hda even when you use /tmp/myowndisk.

There is no intrinsic name for a device - at most a conventional name.
