Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTDGHSC (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 03:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTDGHSC (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 03:18:02 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:26892 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S261968AbTDGHSB (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 03:18:01 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: [PATCH] new syscall: flink
Date: Mon, 7 Apr 2003 07:29:35 +0000 (UTC)
Organization: Cistron Group
Message-ID: <b6r9cv$jof$1@news.cistron.nl>
References: <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org> <b6qruf$elf$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1049700575 20239 62.216.29.200 (7 Apr 2003 07:29:35 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <b6qruf$elf$1@cesium.transmeta.com>,
H. Peter Anvin <hpa@zytor.com> wrote:
>Followup to: 
><Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org>
>By author:    Mark Grosberg <mark@nolab.conman.org>
>> As far as I understand it, isn't the protection information stored in the
>> inode? The flink call is just linking an inode into a directory that the
>> caller has write access to. The permissions and ownership of the file
>> shouldn't change.
>
>The problem is when you get passed a file descriptor from another
>process (via exec or file-descriptor passing) and you don't have
>permissions to access the *directory*.

Can't you just check those permissions, i.e. behave like link() ?
If you cant't access the path to the file, don't permit flink() ?

Mike.
-- 
Linux isnt at war. War involves large numbers of people making losing decisions
that harm each other in a vain attempt to lose last. Linux is about winning.
	-- Alan Cox, linux-kernel, <E1276kG-00019y-00@the-village.bc.nu>

