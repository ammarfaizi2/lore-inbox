Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262636AbSJVOOF>; Tue, 22 Oct 2002 10:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262665AbSJVOOF>; Tue, 22 Oct 2002 10:14:05 -0400
Received: from relay.muni.cz ([147.251.4.35]:24286 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S262636AbSJVOOE>;
	Tue, 22 Oct 2002 10:14:04 -0400
Date: Tue, 22 Oct 2002 16:19:57 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre11 /proc/partitions read
Message-ID: <20021022161957.N26402@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, world!\n

	while trying to figure out why my "vgchange -a y" sometimes works
and sometimes does not, I've come to the following problem:

# dd if=/proc/partitions bs=512|wc -l
1+1 records in
1+1 records out
     12

# dd if=/proc/partitions bs=128k|wc -l
0+1 records in
0+1 records out
     32


	I.e. if you read the /proc/partitions in single read() call,
it gets read OK. However, if you read() with smaller-sized blocks,
you get the truncated contents.

	Are applications expected to read the whole /proc file
in one read()?

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|-- If you start doing things because you hate others and want to screw  --|
|-- them over the end result is bad.   --Linus Torvalds to the BBC News  --|
