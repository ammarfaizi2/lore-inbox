Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310878AbSCHOeH>; Fri, 8 Mar 2002 09:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310879AbSCHOd6>; Fri, 8 Mar 2002 09:33:58 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:19481 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S310878AbSCHOdr>;
	Fri, 8 Mar 2002 09:33:47 -0500
Date: Fri, 8 Mar 2002 15:33:45 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Boszormenyi Zoltan <zboszor@mail.externet.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext2/Ext3 partition label abuse
Message-ID: <20020308143345.GA13406@win.tue.nl>
In-Reply-To: <3C88890C.6010303@mail.externet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C88890C.6010303@mail.externet.hu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 10:49:00AM +0100, Boszormenyi Zoltan wrote:

[I had two disks with the same labels on one machine and that caused
problems with booting]

Yes, if you have an fstab file that says: mount the filesystem with
label "ROOTDISK" on /, and then come with two filesystems that both are
labeled "ROOTDISK", then it is hardly surprising when problems arise.
The same will happen if you use UUID instead of label but created the
other disk by copying the first using dd.

You can change fstab for example with an editor.
You can change labels for example with the e2label utility.

Labels have an advantage for example when you add or remove a SCSI disk:
the label stays the same but the disks are renumbered.
Also when you add or remove partitions, causing a renumbering.
Using UUID is slightly more stable, slightly less user-friendly.

Attaching a significance to the order of items in /proc/partitions
is a bad idea.
