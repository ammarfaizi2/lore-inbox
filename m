Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbSJVQIn>; Tue, 22 Oct 2002 12:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbSJVQIn>; Tue, 22 Oct 2002 12:08:43 -0400
Received: from relay.muni.cz ([147.251.4.35]:16799 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S263794AbSJVQIm>;
	Tue, 22 Oct 2002 12:08:42 -0400
Date: Tue, 22 Oct 2002 18:14:26 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre11 /proc/partitions read
Message-ID: <20021022181426.P26402@fi.muni.cz>
References: <20021022161957.N26402@fi.muni.cz> <Pine.LNX.3.95.1021022110331.3644A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1021022110331.3644A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Oct 22, 2002 at 11:10:29AM -0400
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
:
: > # dd if=/proc/partitions bs=512|wc -l
: > 1+1 records in
: > 1+1 records out
: >      12
: > 
: > # dd if=/proc/partitions bs=128k|wc -l
: > 0+1 records in
: > 0+1 records out
: >      32
: 
: Well yes, sorta. The proc file-system is a compromise. You can
: `cat` it and `more` it, but anything that uses `lseek` will
: fail in strange ways.

	I hope dd(1) does not use lseek() :-) The question is
whether the application should supply a big enough buffer to read(2)
or whether it is possible to read(2) in more smaller chunks.

-Y.

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|-- If you start doing things because you hate others and want to screw  --|
|-- them over the end result is bad.   --Linus Torvalds to the BBC News  --|
