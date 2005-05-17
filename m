Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVEQW4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVEQW4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVEQWPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:15:44 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:23782 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262029AbVEQWPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:15:15 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: =?ISO-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050517220948.GF9121@gmail.com>
References: <20050516085832.GA9558@gmail.com>
	 <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org>
	 <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com>
	 <1116354894.4989.42.camel@mulgrave> <20050517192636.GB9121@gmail.com>
	 <1116359432.4989.48.camel@mulgrave> <20050517195650.GC9121@gmail.com>
	 <1116363971.4989.51.camel@mulgrave>  <20050517220948.GF9121@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 17 May 2005 17:14:57 -0500
Message-Id: <1116368097.4989.59.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 00:09 +0200, Grégoire Favre wrote:
> Could I just take some pictures of the boot process and send them to
> you ?

Not really, the messages I need will be embedded in a lot of other
output and will likely scroll off the screen

> Or is there any way to use an usb palm to catch the console output ?

If it has a serial port, sure, just use a serial console.

If it doesn't, try removing the DVD during boot, then plug it back in
again and trigger a device add

echo scsi add-single-device <n> 0 1 0 > /proc/scsi/scsi

where <n> is whatever SCSI number the rest of your CD-ROM's appear on
(it was 1 in your first trace).

James


