Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263950AbTDHIDw (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 04:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTDHIDw (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 04:03:52 -0400
Received: from grunt5.ihug.co.nz ([203.109.254.45]:55006 "EHLO
	grunt5.ihug.co.nz") by vger.kernel.org with ESMTP id S263950AbTDHIDu (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 04:03:50 -0400
Message-ID: <002501c2fe57$3dfb3b80$0b721cac@stacy>
From: "dave" <davekern@ihug.co.nz>
To: <linux-kernel@vger.kernel.org>
Subject: help writing file system 
Date: Tue, 8 Apr 2003 22:16:53 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i am writing a 2.4.x device driver LNVRM I was going to use proc for debug
and interface
But proc dose not support report files because it dose not have OPEN and
RELASE functions

My report files work like this
    1. OPEN
        Memory is allocated and status information is loaded into the memory
    2. READ
        Normal read of the memory (report)
    5. RELASE
        The report memory is freed

so now I want my driver when is starts to make an mount point in /proc/lnvrm
and then
auto mount my FS also my FS will have whatever status info and a fixed file
in it called
device witch will be a char device node witch will point to my auto assigned
mayor / minor
number  I do not want to use 2.4.x vdev as this way just dose it all in one

I have done proc code before but run into lots of brick wills I guest I need
to know
1. how do you make a mount point in /proc ?
2. how do you auto mount that point ?
3     how do you make a device node in proc ? (I wont use this but it is
interesting to me)

also I have written a read / write FS before but this was mainly by locking
at outer peoples work
is there some relay good info on writing a linux FS for free download ? (no
I don't have any CC's)


thank you



