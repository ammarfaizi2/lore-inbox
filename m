Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbUJ1GPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbUJ1GPp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbUJ1GNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:13:30 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:17164 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262816AbUJ1GJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 02:09:31 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Lei Yang <lya755@ece.northwestern.edu>, linux-kernel@vger.kernel.org,
       kernelnewbies <kernelnewbies@nl.linux.org>
Subject: Re: set blksize of block device
Date: Thu, 28 Oct 2004 09:09:20 +0300
User-Agent: KMail/1.5.4
Cc: Lei Yang <lya755@ece.northwestern.edu>
References: <417FE6A8.5090803@ece.northwestern.edu> <417FE937.1040304@ece.northwestern.edu> <41804F04.4000300@ece.northwestern.edu>
In-Reply-To: <41804F04.4000300@ece.northwestern.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410280909.20141.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> I am learning block device drivers and have a newbie question. Given 
> >> a block device, is there anyway that I could set its block size? For 
> >> example, I want to write a block device driver that will work on an 
> >> existing block device.  In this driver, I want block size smaller. 
> >> (The idea looks confusing but I could explain if anybody is 
> >> interested :- )  However,  typically the block size is 1KB, now I 
> >> want to set it to 512 or 256.  Can I do it?

256 - no way if hardware can do only 512-byte writes.

You need read-modify-write for this.
--
vda

