Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUAaQ6S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 11:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUAaQ6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 11:58:18 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:27867 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264933AbUAaQ6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 11:58:06 -0500
Date: Sat, 31 Jan 2004 17:58:02 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: khubd crash on scanner disconnect
Message-ID: <20040131165802.GA24942@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040130173656.GA4570@merlin.emma.line.org> <20040130191453.GA7173@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130191453.GA7173@kroah.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004, Greg KH wrote:

> Known bug, don't use that module, it's OBSOLETED.  Use xscane and libusb
> instead.

You mean xsane, or any other stuff that uses original SANE backends,
Epkowa's iscan doesn't appear to work yet (but seems to require the
scanner module still), see sane-devel archives:
http://lists.alioth.debian.org/pipermail/sane-devel/2003-December/009803.html

JFTR, my /etc/sane.d/epson.conf (SANE 1.0.10 here) now has:

# /etc/sane.d/epson.conf
# I personally don't need this:
scsi EPSON
# adjust the hex numbers to vendor and product as printed
# by sane-find-scanner, this is for instance an Epson Perfection 1650:
usb libusb
usb 0x04b8 0x0110

KHK's "epson" backend seems to work fine though. scanimage -L, xsane.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
