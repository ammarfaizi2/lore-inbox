Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbTISNDi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 09:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbTISNDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 09:03:38 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:57563 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261554AbTISNDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 09:03:37 -0400
Date: Fri, 19 Sep 2003 14:02:08 +0100
From: Dave Jones <davej@redhat.com>
To: Bernhard Rosenkraenzer <bero@arklinux.org>,
       Marcelo Tossati <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via-rhine apparently broken in 2.4.23-pre4
Message-ID: <20030919130208.GA20814@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bernhard Rosenkraenzer <bero@arklinux.org>,
	Marcelo Tossati <marcelo.tosatti@cyclades.com.br>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0309190254480.18687@dot.kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0309190254480.18687@dot.kde.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 02:58:21AM +0200, Bernhard Rosenkraenzer wrote:
 > Unverified (due to lack of hardware) report from a user:
 > 
 > Updating from 2.4.22 to 2.4.23-pre4 breaks networking with an onboard VIA 
 > Rhine II chip.
 > 
 > It seems to transfer about 2 kB of data, then stall forever.

It sends packets, but doesn't receive any.  To get it working I needed
to apply Andrew de Quincey's ACPI IRQ fixes which are in -ac/-pac
(These, or variants of are must-haves for 2.4.23).

A workaround in the meantime is to boot with pci=noacpi

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
