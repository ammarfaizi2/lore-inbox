Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUDPBbL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 21:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUDPBbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 21:31:11 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:62610
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S261263AbUDPBbI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 21:31:08 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Charles Shannon Hendrix <shannon@widomaker.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040416011401.GD18329@widomaker.com>
References: <20040416011401.GD18329@widomaker.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1082079061.7141.85.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Apr 2004 18:31:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 15/04/2004 klokka 18:14, skreiv Charles Shannon Hendrix:
> 

> NFS server:
> 
>     Sun SS5
>     10baseT ethernet (100baseT card available, not used)
>     NetBSD 1.6.1
>     pretty much a plain vanilla server setup
> 
> Network:
> 
>     simple LAN with three machines, connected via a full duplex
>     multi-speed switch
> 
> NFS client:
> 
>     vanilla PC
>     Intel Pro/100 ethernet
>     Slackware 9.1
>     Linux kernel 2.6.5, plain with no mods or patches, only enough
> 	drivers and features enabled to run my workstation
> 	configuration as close as I could get to my Linux 2.4
> 	kernel

This is pretty much covered in the NFS FAQ entry B10.

You are experiencing the classical effects of using unreliable transport
(i.e. UDP) on a mixed speed network. Writes to the server are getting
lost, because it is on a slow segment that cannot keep up with the
faster 100Mbit clients.

Use the 'proto=tcp' mount option, and all will be well again.

Cheers,
  Trond
