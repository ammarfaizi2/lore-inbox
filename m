Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136427AbREDPTr>; Fri, 4 May 2001 11:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136428AbREDPTi>; Fri, 4 May 2001 11:19:38 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:16720 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S136427AbREDPTc>; Fri, 4 May 2001 11:19:32 -0400
Date: Fri, 4 May 2001 11:20:30 -0400
From: "Michael K. Johnson" <johnsonm@redhat.com>
Message-Id: <200105041520.f44FKUM07323@bastable.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: dhcp problem with realtek 8139 clone with rh 7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-kernel, you wrote:
>I have som problem with my realtek 8139 clone. It won't work with dhcp
>against my isp. I've just installed redhat 7.1 on a i386 with to (exactly
>the same) network cards, one that should be connected to my isp, and one
>to
>the local network. My local network works fine, but when I try to start
>eth0
>(which is the card connecting to my isp) I get
>
>Determining IP configuration... Operation failed.
>   failed.
>
>If I manually try to run 'pump -i eth0' I also get Operation failed.

This sounds more like pump failing to negotiate dhcp properly than
like a failure in the driver.  Let's check that possibility first
before assuming a driver bug.

Install dhcpcd, chmod a-x /sbin/pump, and see if it works better
(if pump is not there or not executable, the scripts fall back to
dhcpcd).  If so, please file a bug report against pump in buzilla
http://bugzilla.redhat.com/bugzilla/

michaelkjohnson

 "He that composes himself is wiser than he that composes a book."
 Linux Application Development                     -- Ben Franklin
 http://people.redhat.com/johnsonm/lad/
