Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTJ2JGc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 04:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbTJ2JGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 04:06:32 -0500
Received: from soft.uni-linz.ac.at ([140.78.95.99]:38291 "EHLO
	zeus.soft.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id S261936AbTJ2JGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 04:06:30 -0500
Message-ID: <3F9F830F.6010803@soft.uni-linz.ac.at>
Date: Wed, 29 Oct 2003 10:06:23 +0100
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Burjan Gabor <buga@elte.hu>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 usbserial/pl2303 oops
References: <20031027083406.GA9326@odin.sis.hu> <20031027234233.GB3408@kroah.com> <20031029001731.GA20355@odin.sis.hu>
In-Reply-To: <20031029001731.GA20355@odin.sis.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a different problem with the pl2303 module, but have
no clue where to search: I have an ericsson cradle that I
check repeatedly if a cell phone is plugged in or not.

I wrote a small program that sends AT commands to the modem
every few seconds, and when an OK arrives, everythings fine.
It is indeed fine, until I unplug the phone and insert it again:
The program writes the 'AT\r\n' correctly, and I do get an answer
of the right length, but the read buffer does contain only zeros,
although the right length is returned.

Some things get me out of this loop of hell:
	o reloading the pl2303 module
	o when I re-insert the phone, I get correct data about every
		tenth try.
	o minicom seems to do additional initialization that cures
		the problem as well.
I looked through straces of minicom as well as the other programs,
but did not find any significant difference. I did also load pl2303
with debug on, and found that it receives the right values in its
internal buffer, but they are not getting out of the module.

Can anyone give me a clue where I should look next?

thanks
Simon



-- 
------------------------------------------------
Dr. Simon Vogl
Department  of   Computer  Science
Johannes Kepler University of Linz
Altenberger Straﬂe 69
A-4040 Linz - Austria

Tel: +43 70 2468 8517  vogl@soft.uni-linz.ac.at
Fax: +43 70 2468 8426   www.soft.uni-linz.ac.at

