Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVARQNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVARQNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 11:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVARQNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 11:13:09 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:24288 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S261332AbVARQNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 11:13:02 -0500
Date: Tue, 18 Jan 2005 17:12:58 +0100
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>, linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050118161258.GB12050@speedy.student.utwente.nl>
Mail-Followup-To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>,
	linux-kernel@vger.kernel.org
References: <2E314DE03538984BA5634F12115B3A4E01BC42AE@email1.mitretek.org> <20050118140203.GH2839@darkside.22.kls.lan> <20050118141707.GA11385@speedy.student.utwente.nl> <20050118152006.GJ2839@darkside.22.kls.lan> <20050118155534.GA12050@speedy.student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118155534.GA12050@speedy.student.utwente.nl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 04:55:34PM +0100, I wrote:
> multiples of the block size. The 2.6 kernel does not have this problem; it
> appears to accept partial blocks, and doesn't even appear to calculate the
> device size (blockdev --getsz and --getsize return 0 on my machine.)
                                               ^^^^^^^^^^^
Please disregard the second half of that sentence; when I ran blockdev --getsz,
I had deleted my loop device already. The device size still reads 20002 sectors
in 2.6. This doesn't change anything though, since the last two sectors of the
device, or the first two sectors of the last block, are still usable in 2.6 and
not in 2.4.

	Sytse
