Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262716AbRE0Ccn>; Sat, 26 May 2001 22:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262719AbRE0Cce>; Sat, 26 May 2001 22:32:34 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:27141 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262716AbRE0Cc0>;
	Sat, 26 May 2001 22:32:26 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: new aic7xxx oopses with AHA2940 
In-Reply-To: Your message of "Sun, 27 May 2001 04:21:30 +0200."
             <20010527042129.A12765@lisa.links2linux.home> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 27 May 2001 12:32:20 +1000
Message-ID: <27691.990930740@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 May 2001 04:21:30 +0200, 
Marc Schiffbauer <marc.schiffbauer@links2linux.de> wrote:
>* Keith Owens schrieb am 27.05.01 um 03:07 Uhr:
>> Since you are failing during modprobe, creating /var/log/ksymoops is a
>> good idea, man insmod, see KSYMOOPS ASSISTANCE.  Reproduce the
>> problem to get a clean oops trace then run it through ksymoops, using
>> the saved module data in /var/log/ksymoops.
>
>OK. Now I cut out the Oops out of my /var/log/messages, then did
>
>cat aic7xxx.oops | ksymoops -k /var/log/ksymoops/20010527040453.ksyms -l
>/var/log/ksymoops/20010527040453.modules > trace1

That one was no good.  Because modprobe failed, the data in
/var/log/ksymoops did not get updated.

>and another run with default options:
>ksymoops 0.7c on i686 2.4.5.  Options used

You should be running ksymoops 2.4.x with 2.4 kernels,from
ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4

>>>EIP; e0a7b3a7 <[aic7xxx]ahc_match_scb+17/c0>   <=====
>Trace; e0a7b79d <[aic7xxx]ahc_search_qinfifo+14d/6b0>
>Trace; e0a7c226 <[aic7xxx]ahc_abort_scbs+66/300>

That trace looks good, now it is up to the aic7xxx maintainer to fix
the problem.

