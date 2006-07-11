Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWGKOid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWGKOid (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWGKOic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:38:32 -0400
Received: from gw.exalead.com ([193.47.80.25]:58531 "EHLO exalead.com")
	by vger.kernel.org with ESMTP id S1750759AbWGKOic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:38:32 -0400
Message-ID: <44B3B7E6.7020902@exalead.com>
Date: Tue, 11 Jul 2006 16:38:30 +0200
From: Xavier Roche <roche+kml2@exalead.com>
Organization: Exalead
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.0.2) Gecko/20060404 SeaMonkey/1.0.1 Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Huge performance issue with cciss driver on HP DL385 servers
 (2.6.13 -> 2.6.17)
References: <44B3A178.2060908@exalead.com> <20060711132231.GG9790@harddisk-recovery.com>
In-Reply-To: <20060711132231.GG9790@harddisk-recovery.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw a écrit :
> AFAIK buffers for direct IO need to be *page* aligned. Use something
> like:
> I guess you got away with it cause your 512 byte alignment happened to
> align on a page, but you shouldn't count on that. However...

This example was actually just a minimal example - the running test is
correctly aligned.

> You should check the return value of pwrite().

Also checked in the "real" stress program.

Note that this problem is hard to reproduce, and might be related to
very strange I/O (and/or DMA access) operation ordering. The fact that
the program must be run just after a reboot (or the problem is not
easily reproductible) is something really fishy.
