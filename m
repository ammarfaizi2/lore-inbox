Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVCIJyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVCIJyD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 04:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVCIJyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 04:54:03 -0500
Received: from web51401.mail.yahoo.com ([206.190.38.180]:42588 "HELO
	web51401.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262221AbVCIJxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 04:53:39 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=u5C5d0EZmCaEkFAjJcGHEWLIonz+6Tlgp6Ov4Yi7X2/+scTlLnBXWB2jiOWQChRHvtIE/oWA2fQxp0RowEYUzTppcvcjZdtDLNRxiKlamXZktMWZlkUeRURyzRmsErWUMbe76MwA3fQ/qnKnSq2QDKPeEeCU4KUaeJfEnp3MF+0=  ;
Message-ID: <20050309095336.48054.qmail@web51401.mail.yahoo.com>
Date: Wed, 9 Mar 2005 10:53:36 +0100 (CET)
From: Joerg Pommnitz <pommnitz@yahoo.com>
Subject: Re: select(2), usbserial, tty's and disconnect
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> There was discussion at one point about doing a tty_hangup() when the  >
USB device was disconnected (this causes the read() to return with 0  >  >
bytes and future open attempts to fail), and a patch was put out to do  >
this. I thought this had been merged, but I could be wrong.

Well, I observed the hanging select with SuSE kernel 2.6.8-24.11, so it is
fairly current. I'm seeing this problem with an Option Wireless UMTS data
card. This card is interesting. It is a CardBus card that presents a USB
OHCI hub to the system. Internally it claims to plug in a USB serial
connector. If you issue a RESET AT command, the kernel tells me that the
USB device virtually plugged into the hub got disconnected. A few seconds
later the gets plugged in again. At this point I would have to reopen the
tty. Unfortunately the disconnect event does not propagate to the
application. I could poke the tty to see whether it is still really there,
but this seems quite hackish.

Regards
  Joerg


	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
