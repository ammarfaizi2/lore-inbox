Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbUKDC6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbUKDC6q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbUKDC6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:58:30 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:11493 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261542AbUKDC5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 21:57:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=YPoi3QRyxAFAQY0avGzR7vWvvbG7Y7JyiN2+rlfZJm6r6L+YE1feP1zjyBzFI/kRbvcw38KFTyI99laYPLbFle/jqic1sphAfC1cSCrKf/KJroDB4dI3WrJl8WCiMq8NqrBaVWSO2K5QitNlXRp36zn3N00K7PYP3ZMutlxx41w=
Message-ID: <a99a678a04110318572509fb7b@mail.gmail.com>
Date: Wed, 3 Nov 2004 21:57:12 -0500
From: George Glover <hyperborean@gmail.com>
Reply-To: George Glover <hyperborean@gmail.com>
To: Thomas Babut <thomas@babut.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.x hangs with Symbios Logic 53c1010 Ultra3 SCSI Adapter
In-Reply-To: <41898E16.8090908@babut.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41898E16.8090908@babut.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2004 03:04:06 +0100, Thomas Babut <thomas@babut.net> wrote:
> Dual Pentium III at 1000 MHz with 1 GByte RAM and Quantum ATLAS10K2-TY367J
...
> sym0:1:0: ABORT operation started.
> sym0:1:0: ABORT operation timed-out.
> sym0:1:0: DEVICE RESET operation started.
> sym0:1:0: DEVICE RESET operation timed-out.
> sym0:1:0: BUS RESET operation started.
> sym0: SCSI BUS reset detected.
> sym0: SCSI BUS has been reset.
> sym0: SCSI BUS operation completed.
> 
> At this point only a hard-reset helps.

You need to upgrade to a more recent kernel, I had the same problem -
it's a known issue with the hard disk's firmware.  That particular
version of the symbios driver added domain validation code which
triggers the bug, the are work-arounds in the latest stable kernel.

George
