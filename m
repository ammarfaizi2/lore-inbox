Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbTHZVat (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 17:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbTHZVat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 17:30:49 -0400
Received: from [66.35.48.5] ([66.35.48.5]:55974 "HELO mail.amsonline.com")
	by vger.kernel.org with SMTP id S262823AbTHZVao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 17:30:44 -0400
Message-ID: <3F4BD073.6020105@coraccess.com>
Date: Tue, 26 Aug 2003 15:26:11 -0600
From: Marcus Hall <mhall@coraccess.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux-arm-2.5.59 problem connecting from win 98
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a PXA-255 (ARM xscale) based system running the 2.5.59-rmk1-pxa1
(+ some trizeps patches) and am having a problem with connecting to the
system from a windows box.

Things work just fine with http/ftp/telnet from a linux box, but if I
try to connect from a win 98 system, linux panics (don't really blame
it..) with the error message 'kernel BUG at net/core/skbuff.c:323',
which appears to say that an skbuff is being freed while still on a
list.

Looking at the packets being sent, it appears that the windows box is
releating the SYN and ACK packets.  This should be legal, but may be
what is confusing the linux system.  The packets I see are:

	windows		linux
		SYN ->
		SYN ->
		<- SYN ACK
		ACK ->
		ACK ->
		data ->
		...

I don't know if the problem occurs on the 2nd SYN, or the 2nd ACK (or,
I guess somewhere else...)

I don't believe that there are any changes in the core networking in
the arm/xscale patches applied to the base 2.5.59 kernel, just some
tweaking of the smc9194 and cs89x0 modules.  It seems unlikely that this
problem would exist in the "official" kernel for long, but it also seems
unlikely to be particular to the arm either...  Is it a known bug
(hopefully with a patch somewhere)?

Thank You!

Marcus Hall
CorAccess Systems

