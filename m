Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262091AbREPU7c>; Wed, 16 May 2001 16:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262093AbREPU7W>; Wed, 16 May 2001 16:59:22 -0400
Received: from comverse-in.com ([38.150.222.2]:35971 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S262091AbREPU7P>; Wed, 16 May 2001 16:59:15 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678ED4@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: ((struct pci_dev*)dev)->resource[...].start
Date: Wed, 16 May 2001 16:58:29 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="koi8-r"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone please confirm if my assumptions below are correct:
1) Unless someone specifically tampered with my driver's device since the OS
bootup, the mapping of the PCI base address registers to virtual memory will
remain the same (just as seen in /proc/pci, and as reflected in <subj>)? If
not, is there a way to freeze it for the time I want to access it?

2) (Basically, the question is "Do I understand Documentation/IO-mapping.txt
right?")
PCI memory, whenever IO type or memory type, can not be dereferenced but
should be accessed with readb() etc. On i386, PCI mem (memory type) can be
accessed by direct pointer access, but this is not portable.

Kind regards,
	Vassilii
