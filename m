Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282747AbRLTJGw>; Thu, 20 Dec 2001 04:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282757AbRLTJGo>; Thu, 20 Dec 2001 04:06:44 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:2058 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282747AbRLTJGa>; Thu, 20 Dec 2001 04:06:30 -0500
Date: Thu, 20 Dec 2001 08:58:44 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Stevie O <stevie@qrpff.net>
Cc: "David S. Miller" <davem@redhat.com>, Mika.Liljeberg@welho.com,
        kuznet@ms2.inr.ac.ru, Mika.Liljeberg@nokia.com,
        linux-kernel@vger.kernel.org, sarolaht@cs.helsinki.fi
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
Message-ID: <20011220085844.A29925@flint.arm.linux.org.uk>
In-Reply-To: <5.1.0.14.2.20011220022218.01dc2258@whisper.qrpff.net> <3C1FA558.E889A00D@welho.com> <20011218.122813.63057831.davem@redhat.com> <5.1.0.14.2.20011220022218.01dc2258@whisper.qrpff.net> <20011219.234020.98861143.davem@redhat.com> <5.1.0.14.2.20011220024656.01e0cd20@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20011220024656.01e0cd20@whisper.qrpff.net>; from stevie@qrpff.net on Thu, Dec 20, 2001 at 02:51:42AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 02:51:42AM -0500, Stevie O wrote:
> hah, I wish. The ARM7 has seven "exception" vectors -- that's it.

If you're running on a processor without CP#15 register 1, and therefore
doesn't have the alignment data abort trap (eg, MMUless ARMs), then you're
on your own.

If you do have it, and you didn't enable the alignment fault handler,
that's your problem as well.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

